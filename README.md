# Infra-As-Code-Helper
***
A set of hcl or playbook files to create resources on private or public infrastructure

## Table of Contents
***
1. [General Info](#general-info)
2. [Technologies](#technologies)
3. [Installation](#installation)
4. [Collaboration](#collaboration)
5. [FAQs](#faqs)

## General Info
***
Easyly create some vms with packer and terraform. 

## Technologies
***
A list of technologies used within this project:
* [terraform]
* [packer]
* [ansible]
* [vsphere]
* [kvm]
* [gcp]
* [azure]

## Installation
***
```bash
$ git clone https://....
$ cd /path/to/the/files
$ vim init_env_lab.sh
```

Start with packer to create templates then use them with terraform.

You need to install a dns with dynamic dns enabled and a loadbalancer. To do so, you can use terraform with vsphere or kvm then use ansible to configure them.

The k8s-cluster-v0 used fixed ip with terraform and ansible whereas k8s-cluster-v1 (ansible/terraform (kvm multiples-vms)) use dhcp.

Nota:
When using dhcp with terraform, the dns module may throw an error if the server address has not been provided quickly. Just wait few seconds then make a terraform refresh, terraform plan and terraform apply again.
