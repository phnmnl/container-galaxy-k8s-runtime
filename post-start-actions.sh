#!/bin/bash

echo "Adding workflows to Galaxy for user $GALAXY_DEFAULT_ADMIN_USER from dir $WORKFLOWS_DIR"


# Waits for the instance to be up and adds the workflows in a non-blocking fashion, so that tail below proceeds
# uses ephemeris. Virtualenv needed while pre 0.8 versions of ephemeris are being used in other places
deactivate
virtualenv .ephemeris-publishable-workflow && \
  source .ephemeris-publishable-workflow/bin/activate && \
  apt-get update && apt-get install -y --no-install-recommends git && \
  pip install -U pip && pip install -e git://github.com/galaxyproject/ephemeris.git@#egg=ephemeris && \
  echo "...dependencies for workflows installed"
  workflow-install -g http://127.0.0.1 -v -a $GALAXY_DEFAULT_ADMIN_KEY \
      -w /export/workflows_to_load --publish_workflows && \
  deactivate && \
  apt-get purge -y git && \
rm -rf .ephemeris-publishable-workflow
