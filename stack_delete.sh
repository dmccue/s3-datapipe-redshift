#!/bin/bash

function ansibleError {
  echo "Error: Ansible did not finish successfully"
  exit 1
}

ansible-playbook -v ansible/cloudformation_delete.yml || ansibleError
