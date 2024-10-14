# Nomad Demo

Demo repo to show Nomad in action.

## Prerequisites

- Nomad installed (<https://developer.hashicorp.com/nomad/docs/install>)

## Setup

1. Start Nomad

```bash
nomad agent -dev -config=config/nomad.hcl
```

2. Deploy the application

```bash
nomad job run nginx.nomad
nomad job status nginx

curl http://$(nomad job status -json nginx | jq -r '.[0].task_groups[0].tasks[0].ip_address'):80
curl http://localhost:8080
```

## Nomad on AWS

```bash
cd aws
mv variables.hcl.example variables.hcl

## Build the AMI
packer init image.pkr.hcl
packer build -var-file=variables.hcl image.pkr.hcl


## Terraform
terraform init
terraform apply -var-file=variables.hcl

## Post-setup

```bash
cd aws
./post-setup.sh

export NOMAD_ADDR=$(terraform output -raw lb_address_consul_nomad):4646 && \
  export NOMAD_TOKEN=$(cat nomad.token)


nomad node status

## Cleanup

terraform destroy 
```
