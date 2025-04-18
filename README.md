# VMware VM Cloning and Windows Configuration Automation

This Ansible playbook automates the process of cloning a VMware virtual machine from a template and configuring Windows settings, including software installation and system customization.

## Playbook Overview

The playbook consists of two main parts:
1. Cloning a VM from a VMware template with network configuration
2. Installing software and configuring the Windows system

## Features

- **VMware VM Cloning**: Creates a new VM from a template with:
  - Static IP configuration
  - Custom DNS settings
  - Timezone configuration
  - Hostname and user account setup
  - Automatic execution of post-deployment scripts

- **Windows Configuration**:
  - Software installation from local sources
  - System directory management
  - Persian (Farsi) keyboard layout addition
  - Temporary file cleanup

## Pre-Sysprep Configuration

> "I created a template and before running the sysprep command, I placed two files:
> - `PostSysprep.ps1`
> - `SetupComplete.cmd`
> in the path `C:\Windows\Setup\Scripts`"

These files are executed during the Windows setup process after sysprep, allowing for custom post-deployment configurations.

## Requirements

- Ansible with Windows support
- `community.vmware` collection
- VMware vCenter credentials
- Windows template with:
  - VMware tools installed
  - WinRM configured
  - Required directories and scripts pre-placed

## Usage

1. Clone the repository
2. Create/edit `vars.yml` with your specific variables:
   ```yaml
   vcenter_hostname: your_vcenter.example.com
   vcenter_username: admin@vsphere.local
   vcenter_password: secure_password
   datacenter_name: DC1
   vm_folder: /Production
   vm_name: new-vm
   template_name: win2019-template
   cluster_name: Cluster1
   datastore_name: DS1
   network_name: VM Network
   ip_address: 192.168.1.100
   subnet_mask: 255.255.255.0
   gateway: 192.168.1.1
   hostname: newserver
   windows_password: AdminPassword123
   fullname_user: Administrator
   orgname_user: MyOrg
   installer_list:
     - { name: "App1", src: "/path/to/app1.exe", dest: "C:\\Temp\\app1.exe", cmd: "C:\\Temp\\app1.exe /silent" }
