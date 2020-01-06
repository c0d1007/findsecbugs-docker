#!/usr/bin/env bash
DOCKER_VERSION_RESPONSE=$(docker -v)
EXPECTED_RESPONSE="Docker version "
DOCKER_IMAGE="shibme/findsecbugs-docker"
if test "${DOCKER_VERSION_RESPONSE#*$EXPECTED_RESPONSE}" != "$DOCKER_VERSION_RESPONSE"; then
  if [ ! -f "$1" ]; then
    echo "Please provide a valid file as argument to scan"
    exit 1
  fi
  docker pull $DOCKER_IMAGE
  docker run -v $(pwd):/workspace findsecbugs-docker \
  bash /findsecbugs/findsecbugs.sh -progress -html -output report.htm "$@"
else
  echo "Please install docker client before you begin."
fi