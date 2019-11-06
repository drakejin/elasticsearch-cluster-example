#!/bin/bash

mkdir -p ./dockerfiles/elasticsearch/config

cp -R ../../provisioning/roles/elasticsearch/files/utils ./dockerfiles/elasticsearch/config/utils
