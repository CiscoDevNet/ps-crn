# PS-CRN Automation

This is VIRL topology and automated tooling for the [Public Sector Cloud Read Network](README.md).

## Requirements

* [virlutils](https://github.com/CiscoDevNet/virlutils)
* [ansible-viptela](https://github.com/CiscoDevNet/ansible-viptela)
* A Viptela license file and the Organization name associated with that license file.  The Organization name should be provided where you see: `<your org name>`

## Topology

![Alt Text](images/virl_topology.png)

_The default username/password is for network elements: `admin/admin`_

_The default username/password is for network elements: `virl/admin`_

_NOTE: The Topology requires images for vmanage, vbond, vsmart, vedge, and CSR1000v_

### Cloning the workshop repo repo:

``` shell
git clone --recursive https://wwwin-github.cisco.com/ciscops/ps-crn.git 
```
>For more help with git, see DevNet's [A Brief Introduction to Git](https://learninglabs.cisco.com/lab/git-basic-workflows/step/1)

### Install requirements:

Navigate to the `ps-crn` directory.

``` shell
$ cd ps-crn/
```

>Note: All subsequent exercises will be in this directory unless otherwise noted.


Install python requirements:
```
pip install -r requirements.txt
```

Install sshpass (see [pre-requisites](../../pre-requisites.md)).

### Create `.virlrc` if it does not exist

Create a file named `.virlrc` in the `ps-crn` directory:
``` shell
VIRL_USERNAME=guest
VIRL_PASSWORD=guest
VIRL_HOST=your.virl.server
```

>Note: your values will be different.

### Next Steps:
* [Build the topology](virl/build.md)
* [Configure the topology](virl/configure.md)
* [Clean the topology](virl/clean.md)