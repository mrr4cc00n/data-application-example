#!/bin/bash

set -e

# OVERVIEW
# This script installs a single conda package in a single SageMaker conda environments.

sudo -u ec2-user -i <<'EOF'
# PARAMETERS
ENVIRONMENT=python3

conda install -c conda-forge python-snappy fastparquet snappy pyarrow apscheduler boto3 --name "$ENVIRONMENT" --yes

EOF
