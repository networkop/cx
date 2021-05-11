#!/bin/bash
docker build -t cx .
docker rm -f cumulus
docker run -d --name cumulus --privileged cx
