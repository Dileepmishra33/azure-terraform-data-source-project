# azure-terraform-data-source-project
# Azure Terraform Data Source Project

## Overview

This project demonstrates Azure infrastructure deployment using Terraform Data Sources.

In this project, I have used Terraform Data Sources to fetch existing Azure resources and deploy infrastructure components.

Resources Used:
- Resource Group Data Source
- Virtual Network Data Source
- Subnet Data Source
- Network Interface
- Virtual Machine

## Implementation

Two approaches are implemented:

### Approach 1: Individual Data Sources

Using individual data blocks to fetch existing Azure resources.

Resources:
- Resource Group
- VNet
- Subnet


### Approach 2: Data Sources with for_each

Using for_each with Data Sources to dynamically manage multiple resources.

Resources:
- Multiple Resource Groups
- Multiple VNets
- Multiple Subnets
- Multiple NICs
- Multiple Virtual Machines


## Terraform Concepts Used

- AzureRM Provider
- Variables
- Data Sources
- for_each
- Output Values
- Resource Dependencies
