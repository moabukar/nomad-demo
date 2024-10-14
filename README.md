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
