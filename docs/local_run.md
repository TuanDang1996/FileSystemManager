# Running Project Locally

1. [Run the code locally](#run-the-code-locally)
2. [Provision your infra + test ansible](#provision-your-infra-and-deploy-application)
3. [Destroy infra](#destroy-infra)


### Run the code locally

If you want to test the application, you can do these steps:

- Ensure that already installed docker + docker-compose. If not, follow [this](https://docs.docker.com/compose/install/) to install.
- Run this command to build and start locally: <mark style="background-color: #e6e6e3">docker-compose -f ./local/docker-compose.yml up  -d --build</mark>
- Go to http://localhost:8080 to test the application
- Run this command to shut down the app: <mark style="background-color: #e6e6e3">docker-compose -f ./local/docker-compose.yml down</mark>

### Provision your infra and deploy application

##### Prerequisite:

There are some prerequisites before start provision infra and deploy:
- Setup aws environment: install [aws-cli](#https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html), after that follow [this user guide](#https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html) to set up aws profile on the local machine.
- Install terraform: follow [this user guide](#https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) to install terraform
- Install Ansible: follow [this user guide](#https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) to install ansible
- Generate ssh key: run the command <mark style="background-color: #e6e6e3">ssh-keygen -t RSA</mark> to generate the ssh key
- Create S3 bucket to store terraform state: create a bucket on AWS S3 to store tfstate file
- Set up environment variables:
  1. export DOCKER_USERNAME={username} : username of docker hub repository
  2. export DOCKER_PASSWORD={password}: password for the username
  
#### Actions

After complete the [Prerequisite](#prerequisite), run this command to provision infra and deploy app: <mark style="background-color: #e6e6e3">sh ./local/provision_and_deploy.sh {public_key_path} {private_key_path} {terraform_bucket}
</mark></br>
with:
- _public_key_path_: the public ssh key path that is generated in the [Prerequisite](#prerequisite) part, ex: ~/.ssh/id_rsa.pub 
- _private_key_path_: the private ssh key path that is generated in the [Prerequisite](#prerequisite) part, ex: ~/.ssh/id_rsa
- _terraform_bucket_: the bucket to store the terraform state file that is generated in the [Prerequisite](#prerequisite) part, ex: test-terraform-state-527552148303.</br></br>
 
   Example command:</br> sh ./local/provision_and_deploy.sh ~/.ssh/id_rsa.pub ~/.ssh/id_rsa "test-terraform-state-527552148303"

### Destroy infra

After the testing is completed, pls run this command to destroy the test environment: <mark style="background-color: #e6e6e3">sh ./local/destroy_infra.sh {terraform_bucket}</mark></br> 
with:</br>

- _terraform_bucket_: the bucket to store the terraform state file that is generated in the [Prerequisite](#prerequisite) part, ex: test-terraform-state-527552148303.</br></br>

Example command:  sh ./local/destroy_infra.sh "test-terraform-state-527552148303" 