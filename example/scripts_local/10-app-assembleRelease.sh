#!/bin/bash
# Example of a script that can be mounted into the android-build container in order to execute commands when the entrypoint-local.sh script is run.

cd $WORK_DIR

./gradlew app:assembleRelease