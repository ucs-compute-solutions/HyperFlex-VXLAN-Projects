# Cisco HyperFlex Stretched Cluster with Cisco DCNM managed VXLAN Multi-Site Fabric Solution

## Table of Contents
* [Overview](Overview)
* [Solution Topology](Solution-Topology)
* [Solution Components](Solution-Components)
* [Prerequisites](Prerequisites)
* [Terraform Scripts](Terraform-Scripts)
* [Terraform Version](Terraform-Version)
* [Terraform Providers](Terraform-Providers)
* [Solution Deployment](Solution-Deployment) 
  - [Clone Github Collection](Clone-Github-Collection)
  - [Update Variables](Update-Variables)
  - [Execute Terraform Plans](Execute-Terraform-Plans)
* [Resources](Resources)

## Overview 

This repository contains the Terraform (TF) plans for the Day 1-2 provisioning of the Cisco DCNM managed VXLAN Multi-Site fabric used in the design for the [Cisco HyperFlex 4.0 for Business Continuity using VMware vSphere 6.7 and VXLAN EVPN Multi-Site Fabric](https://www.cisco.com/c/en/us/td/docs/unified_computing/ucs/UCS_CVDs/hyperflex_4_vsphere6_7_vxlan.html) solution. The scripts assumes that this is a new deployment with only Day 0 provisioning complete.  

The Terraform plans provision the following aspects of the solution:

 1.  Adds a leaf switch pair to the VXLAN fabric in Site-A as access/ToR switches for the Cisco UCS and HyperFlex infrastructure in Site-A.
 2.  Adds a leaf switch pair to the VXLAN fabric in Site-B as access/ToR switches for the Cisco UCS and HyperFlex infrastructure in Site-B.
 3.  Sets up Site-A leaf switch pair as virtual port-channel (vPC) peers to connect to Cisco UCS Fabric Interconnects in Site-A.
 4.  Sets up Site-B leaf switch pair as virtual port-channel (vPC) peers to connect to Cisco UCS Fabric Interconnects in Site-B.
 5.  Enables access Layer (vPC) Connectivity from a pair of leaf switches in Site-A to the Cisco UCS Fabric Interconnects in Site-A.
 6.  Enables access Layer (vPC) Connectivity ffrom a pair of leaf switches in Site-B to the Cisco UCS Fabric Interconnects in Site-B.
 7.  Creates Infrastructure Tenant (VRF) and Networks to enable In-Band management, Storage, and vMotion connectivity between HyperFlex 
     stretched cluster nodes in each data center (DC) site. The In-Band Management network is also used by ESXi hosts in the VMware vSphere cluster. The VXLAN multi-site fabric also provides external connectivity to enable VMware vCenter and HyperFlex Witness to communicate with the HyperFlex stretched cluster nodes and ESXi hosts vai the in-band management network. 


## Solution Topology

A high level view of the solution topology is shown below. 

![image](https://user-images.githubusercontent.com/24396268/136296649-4a5bad55-8278-4dd2-950f-05958a67980e.png)

## Solution Components
The software versions of the components validated in this solution are:  

* Cisco HyperFlex Stretched Cluster: 4.0(2f)
* Cisco HyperFlex Witness: 1.1.1
* Cisco UCS Manager: 4.0(4k)
* VMware vCenter Server 7.0 
* VMware ESXi: 6.7P05 
* Cisco Data Center Network Manager (Cisco DCNM): 11.5(1)
* Cisco Nexus 9000 series switches: NX-OS 9.3(7a) 


## Prerequisites

 *  Basic understanding of how traffic forwarding works in a VXLAN fabric and the constructs and parameters required to implement it
 *  Basic understanding of the overall solution design - see [Cisco Validated Design](https://www.cisco.com/c/en/us/td/docs/unified_computing/ucs/UCS_CVDs/hyperflex_4_vsphere6_7_vxlan.html) for the solution.
 *  VXLAN Multi-Site fabric is up and operational with connectivity to external networks and between sites. 
 *  Management Workstation for executing Terraform scripts. It should be Linux-based workstation with tools such as GIT and an IDE 
    (for e.g. VSCode) deployed to clone this repo, and to edit and execute the Terraform plans.
 *  Physically deploy the access layer components (Leaf Switches, UCS FI, HyperFlex servers) in each site with connectivity between       
    the components. Also perform any initial device configuration that maybe needed. Initial setup of the Cisco UCS Fabric Interconnects must be complete. The uplinks from the UCS FI to the leaf switches must physically connected and configured for port-channeling. The HyperFlex servers should also be physically connected to the Cisco UCS FIs.   
   
## Terraform Scripts

The following Terraform plans are in the solution directory: `HX-SC-VXLAN-MS`. 
```
HXV-VXLAN-0-Providers.tf
HXV-VXLAN-1-AddSwitch-SiteA.tf
HXV-VXLAN-1-AddSwitch-SiteB.tf
HXV-VXLAN-2-SetupVPCLeafPair-SiteA.tf
HXV-VXLAN-2-SetupVPCLeafPair-SiteB.tf
HXV-VXLAN-3-AccessLayerConnectivity-SiteA.tf
HXV-VXLAN-3-AccessLayerConnectivity-SiteB.tf
HXV-VXLAN-4-ConfigInfraTenant-VRF.tf
HXV-VXLAN-5-ConfigInfraTenant-NET1.tf
HXV-VXLAN-5-ConfigInfraTenant-NET2.tf
HXV-VXLAN-5-ConfigInfraTenant-NET3.tf
HXV-VXLAN-6-DeployInfraTenant-NET.tf
```

The provisioning implemented in the above TF plans are summarized below. 

1. **HXV-VXLAN-1-AddSwitch-SiteA.tf**: 
Adds a pair of leaf switches to the VXLAN fabric in Site-A as access/ToR switches for the Cisco UCS domain and HyperFlex servers in Site-A  
2. **HXV-VXLAN-1-AddSwitch-SiteB.tf**: 
Adds a pair of leaf switches to the VXLAN fabric in Site-B as access/ToR switches for the Cisco UCS domain and HyperFlex servers in Site-B
3. **HXV-VXLAN-2-SetupVPCLeafPair-SiteA.tf**: 
Sets up the access leaf switch pair in Site-A as virtual port-channel (vPC) peers for connecting to Cisco UCS Cisco UCS Fabric Interconnects in Site-A
4. **HXV-VXLAN-2-SetupVPCLeafPair-SiteB.tf**: 
Sets up the access leaf switch pair in Site-B as virtual port-channel (vPC) peers for connecting to Cisco UCS Cisco UCS Fabric Interconnects in Site-B
5. **HXV-VXLAN-3-AccessLayerConnectivity-SiteA.tf**: 
Enables access layer (vPC) connectivity from Site-A leaf switch pair to the Cisco UCS Fabric Interconnects in Site-A. 
6. **HXV-VXLAN-3-AccessLayerConnectivity-SiteB.tf**: 
Enables access layer (vPC) connectivity from Site-B leaf switch pair to the Cisco UCS Fabric Interconnects in Site-B. 
7. **HXV-VXLAN-4-ConfigInfraTenant-VRF.tf**: 
Creates Infrastructure Tenant to enable infrastructure connectivity for the HyperFlex Stretched cluster that spans two DC sites. 
8. **HXV-VXLAN-5-ConfigInfraTenant-NET[1-3].tf**: 
Provisions Infrastructure networks (In-Band Mgmt., Storage Data, and vMotion) for the HyperFlex stretched cluster and enables connectivity between sites for these networks. Also enables external connectivity from the In-band mgmt. network to VMware vCenter and HyperFlex Witness outside the fabric (3rd site).
9. **HXV-VXLAN-6-DeployInfraTenant-NET.tf**: 
Deploys the networks to enable the connectivity provisioned in Step 8 above. 

```
Note: 
- TF Plans [1] through [9] must be complete before starting the HyperFlex stretched cluster installation.
- TF Plans [7] through [9] can be repeated to create the Application Tenant and corresponding networks. 
```

## Terraform Version

The Terraform version used to validate the scripts in this repo is:
```
CiscoTerraFormProjects % terraform -version
Terraform v0.15.5
```
## Terraform Providers

The Terraform Providers used by the Terraform scripts are: 

```
terraform {
  required_providers {
    dcnm = {
      source = "CiscoDevNet/dcnm"
      version = "1.0.0"
    }
    provider "time" {
      # Configuration options
    }
  }
}
```

##  Solution Deployment 

To deploy a VMware based Virtual Server Infrastructure (VSI) on a HyperFlex stretched cluster that spans two active-active data center sites, the VXLAN Multi-Site fabric must be first provisioned. The Terraform plans to automate the Day-2 provisioning of the VXLAN Multi-Site fabric should be executed as outlined below. 

###  Clone Github Collection

Clone the GitHub collection named `HyperFlex-VXLAN-Projects` to a new empty folder on the management workstation. Cloning the collection creates a local copy, which is then used to run the Terraform plans that have been created for this solution. 

To clone the GitHub collection, complete the following steps from the management workstation:

1.	Create a new folder for the project. The GitHub collection will be cloned to a folder inside this one, named `HyperFlex-VXLAN-Projects`.
2.	Change directories to the newly created folder.
3.	Clone the GitHub collection using the command: `git clone https://github.com/ucs-compute-solutions/HyperFlex-VXLAN-Projects`
4.	Change directories to the folder with the collection named `HyperFlex-VXLAN-Projects` and then the sub-directory for this solution: `HX-SC-VXLAN-MS`.

### Update Variables

Define the variables that should be used to configure the VXLAN fabric in a `variables.auto.tfvars` file. In Terraform, the variables are declared in the `variables.tf` file and the values for the variables are  specified in a separate file called `variables.auto.tfvars`. A sample file with the parameters used in this solution are provided as a reference. 

### Execute Terraform Plans

1. **Terraform Init**

- The `init` command is used to initialize the Terraform environment for the script being run. Any additional provider modules, such as the Cisco DCNM provider, are downloaded and all prerequisites are checked. This initialization only needs to be run once per script, and subsequent runs only need to execute plan and apply.   
- To initialize the environment, via the CLI change to the `HyperFlex-VXLAN-Projects` folder where the GitHub repository was cloned, then execute:
```
terraform init
```
2. **Terraform Plan**

- The `plan` command is used to evaluate the Terraform script for any syntax errors or other problems. The script will be evaluated against the existing environment and a list of planned actions will be shown. If there are no errors and the planned actions appear correct, then it is safe to proceed to running the apply command in the next step. 

- To evaluate the Terraform plan, via the CLI change to the `HyperFlex-VXLAN-Projects` folder where the GitHub repository was cloned, then execute:
```
terraform plan 
```
3. **Terraform Apply**

- The `apply` command will deploy the new configuration. This command will repeat the planning phase and then ask for confirmation to continue with creating the new resources. 
- To execute the Terraform plan, via the CLI change to the `HyperFlex-VXLAN-Projects` folder where the GitHub repository was cloned, then execute:
```
terraform apply 
```

## Resources

For more information, see: 

* [Cisco DCNM Provider](https://registry.terraform.io/providers/CiscoDevNet/dcnm/latest)
