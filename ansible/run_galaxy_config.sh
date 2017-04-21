#!/bin/bash


###
# This script expects to run in the galaxy root directory

my_name="$(basename "${0}")"
WorkflowDir='./workflows'

function log() {
  # Date not necessary -- k8s already dates all log entries
  echo -e "[ ${my_name} ]" -- $@ >&2
}

function error_trap() {
  log "**** Error at line ${BASH_LINENO[0]} running command ${BASH_COMMAND} ****"
}

trap error_trap ERR
set -o errexit

if [ -z $GALAXY_SEC_DB_ENGINE ]; then
  mkdir -p /opt/galaxy_data/database-sqlite
  log "Galaxy sqlite directory created since we are not using postgresql"
fi


sudo apt-get update -y && sudo apt-get install -y --no-install-recommends ansible
ansible-playbook -i "localhost," -c local ansible/set-galaxy-config-values.yaml
log "Playbook for galaxy config run."

if [ ! -z $SUPP_GROUPS ]; then
  mv config/job_conf.xml config/job_conf.xml.original
  sed s/\"k8s_supplemental_group_id\"\>0/\"k8s_supplemental_group_id\"\>$SUPP_GROUPS/ config/job_conf.xml.original > config/job_conf.xml
  log "Changed supplemental group id from 0 to $SUPP_GROUPS on job_conf.xml"
fi

if [ ! -z $FS_GROUP ]; then
  mv config/job_conf.xml config/job_conf.xml.original
  sed s/\"k8s_fs_group_id\"\>0/\"k8s_fs_group_id\"\>$FS_GROUP/ config/job_conf.xml.original > config/job_conf.xml
  log "Changed fs group id from 0 to $FS_GROUP on job_conf.xml"
fi

if [ ! -z $GALAXY_PVC ]; then
  mv config/job_conf.xml config/job_conf.xml.original
  sed s/k8s_persistent_volume_claim_name\"\>.*\</k8s_persistent_volume_claim_name\"\>$GALAXY_PVC\</ config/job_conf.xml.original > config/job_conf.xml
  log "Set PersistentVolumeClaim to use with Galaxy to $GALAXY_PVC on job_conf.xml"
fi

# if admin email, api and password env variables are set, then start galaxy, run user creation and stop galaxy
if [ ! -z $GALAXY_ADMIN_EMAIL ] && [ ! -z $GALAXY_ADMIN_PASSWORD ] && [ ! -z $GALAXY_API_KEY ]; then
  # ini file will be set already at this point with these variables, we only need to start galaxy
  # wait for it to be available for API calls and create the new user
  log "Need to set up galaxy database for admin user setup..."
  rm -f paster.pid
  ./run.sh --daemon
  # Running ./run.sh --daemon --wait doesn't work for single instances set up, discuss with galaxy core.
  # Using similar logic inside run.sh in the meantime.
  start_time=$(date +%s)
  while true; do
    sleep 1
    printf "." >&2
    # Grab the current pid from the pid file
    if ! current_pid_in_file=$(cat paster.pid); then
        log "Galaxy process died, interrupting"
        exit 1
    fi
    # Search for all pids in the logs and tail for the last one
    latest_pid=$(egrep '^Starting server in PID [0-9]+\.$' "paster.log" -o | tail -n 1 | sed 's/Starting server in PID //g;s/\.$//g')
    # If they're equivalent, then the current pid file agrees with our logs
    # and we've succesfully started
    [ -n "$latest_pid" ] && [ "$latest_pid" -eq "$current_pid_in_file" ] && break
  done
  end_time=$(date +%s)
  log "Galaxy is up and ready for API calls after $((${end_time} - ${start_time})) seconds."
  log "Running admin user creation..."
  source .venv/bin/activate
  log "Workflow directory: ${WorkflowDir}"
  python ansible/configure_galaxy.py --workflow-dir "${WorkflowDir}" \
     $GALAXY_API_KEY $GALAXY_ADMIN_USER $GALAXY_ADMIN_EMAIL $GALAXY_ADMIN_PASSWORD >&2
  deactivate
  ./run.sh --stop-daemon
  log "Galaxy instance configured and stopped.  Removing the master API key"
  ansible-playbook -i "localhost," -c local ansible/remove-api-key.yaml
  # galaxy is started again as part of the next command outside of this script.
fi

exit 0
