#!/bin/bash

# This Script will install Ansible and Terraform
# Also Check and Confirms the success of Installation
# To Run => sudo ./provision.sh

TERRAFORM_VERSION="0.14.3"

install_terraform() {
    # Terraform installation
    echo "Installing Terraform..."
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    sudo apt install unzip
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    chmod +x terraform
    sudo mv terraform /usr/local/bin
}

check_installation() {
    # Checking Terraform Version
    terraform --version

    if [[ "${?}" -eq 0 ]];
    then
        echo "Terraform Working"
    else
        echo "Terraform Not Working"
    fi

}
sudo apt-get update

if [[ "${?}" -eq 0 ]];
then
    install_terraform
    echo "Terraform Installation Completed Successfully"
else
    echo "Terraform Installation Failed"
    exit 1
fi

# Checks the Installation of Tools
check_installation

exit 0
