#!/bin/bash
sudo apt-get update -y && sudo apt-get install -y --no-install-recommends ansible
ansible-playbook -i "localhost," -c local ansible/set-galaxy-config-values.yaml
echo "Playbook for galaxy config run."

# if admin email, api and password env variables are set, then start galaxy, run user creation and stop galaxy
if [ ! -z $GALAXY_ADMIN_EMAIL ] && [ ! -z $GALAXY_ADMIN_PASSWORD ] && [ ! -z $GALAXY_API_KEY ]; then
	# ini file will be set already at this point with these variables, we only need to start galaxy
	# wait for it to be available for API calls and create the new user
	echo "Set up galaxy database for admin user setup..."
	./run.sh --daemon
	# Running ./run.sh --daemon --wait doesn't work for single instances set up, discuss with galaxy core.
	# Using similar logic inside run.sh in the meantime. 
	while true; do
                sleep 1
                printf "."
                # Grab the current pid from the pid file
                if ! current_pid_in_file=$(cat paster.pid); then
                    echo "A Galaxy process died, interrupting" >&2
                    exit 1
                fi
                # Search for all pids in the logs and tail for the last one
                latest_pid=$(egrep '^Starting server in PID [0-9]+\.$' "paster.log" -o | sed 's/Starting server in PID //g;s/\.$//g' | tail -n 1)
                # If they're equivalent, then the current pid file agrees with our logs
                # and we've succesfully started
                [ -n "$latest_pid" ] && [ "$latest_pid" -eq "$current_pid_in_file" ] && break
        done
	echo "Galaxy is ready for API calls..."
	echo "Running admin user creation..."
	source .venv/bin/activate
	python ansible/create_admin_user.py $GALAXY_API_KEY $GALAXY_ADMIN_USER $GALAXY_ADMIN_EMAIL $GALAXY_ADMIN_PASSWORD
	deactivate
	echo "User created, stopping galaxy..."
	./run.sh --stop-daemon
	echo "Galaxy stopped, removing key.."
	ansible-playbook -i "localhost," -c local ansible/remove-api-key.yaml
	# galaxy is started again as part of the next command outside of this script.
fi


