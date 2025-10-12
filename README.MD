# Terraform state PostgreSQL backend

Hosts a PostgreSQL database to use as a [Terraform backend](https://developer.hashicorp.com/terraform/language/backend/pg).

This repository contains both a `deploy.yml` and a nearly identical `initialize.yml`:  
`deploy.yml` has a circular dependency: `deploy.yml` requires a Terraform backend, which this repository provides.  
While acceptable most of the time, if the Terraform backend needs to be restored from scratch, use `initialize.yml` to skip all steps dependent on the Terraform backend until Docker provisions the Terraform backend.
