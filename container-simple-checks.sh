#!/usr/bin/bash

DIRECTORY=/galaxy
if [ ! -d "$DIRECTORY" ]; then
   echo "Galaxy directory $DIRECTORY not found, test failed"
   exit 1
fi

RUNSCRIPT=/galaxy/run.sh
if [ ! -x "$RUNSCRIPT" ]; then
   echo "Galaxy $RUNSCRIPT executable script not found or not executable"
   exit 1 
fi

echo "Simple test passed"
