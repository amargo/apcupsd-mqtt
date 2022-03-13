#!/bin/bash

APCUPSD_IMAGE_VERSION=3-alpine
APCUPSD_TAG_BASE=gszoboszlai/apcupsd-mqtt-ha

docker build --no-cache --rm -t $APCUPSD_TAG_BASE:$APCUPSD_IMAGE_VERSION .
docker push $APCUPSD_TAG_BASE:$APCUPSD_IMAGE_VERSION
docker image tag $APCUPSD_TAG_BASE:$APCUPSD_IMAGE_VERSION $APCUPSD_TAG_BASE:latest
docker push $APCUPSD_TAG_BASE:latest
