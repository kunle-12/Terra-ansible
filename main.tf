name: Deploy Azure VM with Terraform & Configure with Ansible

on:
  workflow_dispatch:
  push:
    branches:
      - main

env:
  TF_LOG: INFO
  ARM_CLIENT_ID: ${{ secrets.ARM_CLIENT_ID }}
  ARM_CLIENT_SECRET: ${{ secrets.ARM_CLIENT_SECRET }}
  ARM_SUBSCRIPTION_ID: ${{ secrets.ARM_SUBSCRIPTION_ID }}
  ARM_TENANT_ID: ${{ secrets.ARM_TENANT_ID }}

permissions:
  contents: read

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Set up Terraform
      uses: hashicorp/setup-terraform@v3
      with:
        terraform_version: 1.6.0

    - name: Terraform Init
      run: terraform init

    - name: Terraform Apply
      id: tfapply
      run: |
        terraform apply -auto-approve

    - name: Save Private Key
      run: |
        terraform output -raw private_key_pem > private_key.pem
        chmod 600 private_key.pem

    - name: Get VM IP
      id: vmip
      run: |
        echo "ip=$(terraform output -raw vm_ip)" >> "$GITHUB_OUTPUT"

    - name: Install Ansible
      run: |
        python3 -m pip install --upgrade pip
        pip install ansible

    - name: Wait for SSH to become available
      run: |
        for i in {1..60}; do
          nc -z ${{ steps.vmip.outputs.ip }} 22 && break
          echo "Waiting for SSH on ${{ steps.vmip.outputs.ip }}..."
          sleep 5
        done

    - name: Run Ansible Playbook
      run: |
        ansible-playbook -i '${{ steps.vmip.outputs.ip }},' \
          -u azureuser \
          --private-key private_key.pem \
          ansible/site.yml
