#!/bin/bash

my_name="$(basename "${0}")"

function log() {
  echo -e $(date +"%F %T") "[ ${my_name} ]"  -- $@ >&2
}

function error_trap() {
  log "**** Error at line ${BASH_LINENO[0]} running command ${BASH_COMMAND} ****"
}

trap error_trap ERR
set -o errexit

sudo apt-get update -y && sudo apt-get install -y --no-install-recommends ansible
ansible-playbook -i "localhost," -c local ansible/set-galaxy-config-values.yaml
log "Playbook for galaxy config run."

# if admin email, api and password env variables are set, then start galaxy, run user creation and stop galaxy
if [ ! -z $GALAXY_ADMIN_EMAIL ] && [ ! -z $GALAXY_ADMIN_PASSWORD ] && [ ! -z $GALAXY_API_KEY ]; then
	# ini file will be set already at this point with these variables, we only need to start galaxy
	# wait for it to be available for API calls and create the new user
	log "Need to set up galaxy database for admin user setup..."
	rm -f paster.pid
	./run.sh --daemon
	# Running ./run.sh --daemon --wait doesn't work for single instances set up, discuss with galaxy core.
	# Using similar logic inside run.sh in the meantime.
	while true; do
                sleep 1
                printf "." >&2
                # Grab the current pid from the pid file
                if ! current_pid_in_file=$(cat paster.pid); then
                    log "A Galaxy process died, interrupting"
                    exit 1
                fi
                # Search for all pids in the logs and tail for the last one
                latest_pid=$(egrep '^Starting server in PID [0-9]+\.$' "paster.log" -o | tail -n 1 | sed 's/Starting server in PID //g;s/\.$//g')
                # If they're equivalent, then the current pid file agrees with our logs
                # and we've succesfully started
                [ -n "$latest_pid" ] && [ "$latest_pid" -eq "$current_pid_in_file" ] && break
        done
	log "Galaxy is up and ready for API calls..."
	log "Running admin user creation..."
	source .venv/bin/activate
	python ansible/create_admin_user.py $GALAXY_API_KEY $GALAXY_ADMIN_USER $GALAXY_ADMIN_EMAIL $GALAXY_ADMIN_PASSWORD >&2
	deactivate
	./run.sh --stop-daemon
	echo "Galaxy stopped, removing key.."
	ansible-playbook -i "localhost," -c local ansible/remove-api-key.yaml
	# galaxy is started again as part of the next command outside of this script.
fi


