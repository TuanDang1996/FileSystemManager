#!/bin/bash
set -e

export TF_BUCKET=$1

cd ./infra

export TF_VAR_public_key="a"
terraform init -get=true -input=false -reconfigure -backend-config="bucket=${TF_BUCKET}" -backend-config="key=terraform.tfstate" -backend-config="region=ap-southeast-1"
terraform destroy -auto-approve