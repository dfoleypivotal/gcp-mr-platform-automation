#!/bin/bash

set -e

fly set-pipeline -t central2 -c pipeline.yml -p user-org-space-mgmt -l vars.yml
fly set-pipeline -t west2 -c pipeline.yml -p user-org-space-mgmt -l vars.yml
