#!/bin/bash
set -e

export PUBLIC_KEY_PATH=$1
export PRIVATE_KEY_PATH=$2
export TF_BUCKET=$3

echo "Public key path: ${PUBLIC_KEY_PATH}"
echo "Private key path: ${PRIVATE_KEY_PATH}"

provision_infra()
{
  echo
  echo "================================================"
  echo "Begin provision infrastructure by terraform...."
  cd ./infra
  export TF_VAR_public_key=$(cat $PUBLIC_KEY_PATH)
  terraform init -get=true -input=false -reconfigure -backend-config="bucket=${TF_BUCKET}" -backend-config="key=terraform.tfstate" -backend-config="region=ap-southeast-1"
  terraform plan -out tfapply
  terraform apply tfapply

  public_ip=$(terraform output public_ip | tr -d '\"')
  echo [remote]$'\n'$public_ip > ../ansible/hosts
  cd ..
  echo "Complete provision infrastructure by terraform!!!"
  echo "================================================"
}

config_and_deploy()
{
  echo
  echo "================================================"
  echo "Begin config and deploy the app..."
  cd ./ansible
  cp -rf $PRIVATE_KEY_PATH ./ec2
  chmod 0600 ec2

  ansible-playbook -i hosts docker.yml
  ansible-playbook -i hosts mounting_ebs.yml
  ansible-playbook -i hosts deploy.yml
  echo "Complete config and deploy the app!!!"
  echo "================================================"
  cd ..
}

provision_infra
config_and_deploy

exit 0