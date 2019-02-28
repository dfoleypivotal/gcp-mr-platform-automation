#!/bin/bash

set -e

fly set-pipeline -t central2 -c gcp-pas-pipeline.yml -p configure-pcf -l environments/central/pipeline-params.yml
fly set-pipeline -t west2 -c gcp-pas-pipeline.yml -p configure-pcf -l environments/west/pipeline-params.yml
fly set-pipeline -t central2 -c gcp-upgrade-opsman.yml -p upgrade-opsman -l environments/central/pipeline-params.yml
fly set-pipeline -t west2 -c gcp-upgrade-opsman.yml -p upgrade-opsman -l environments/west/pipeline-params.yml
