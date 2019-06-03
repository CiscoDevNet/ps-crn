# PS-CRN Automation

This is VIRL topology and automated tooling for the [Public Sector Cloud Read Network](README.md).

## Requirements

* [virlutils](https://github.com/CiscoDevNet/virlutils)
* [ansible-viptela](https://github.com/CiscoDevNet/ansible-viptela)
* A Viptela license file and the Organization name associated with that license file.  The Organization name should be provided where you see: `<your org name>`

## Topology

![Alt Text](images/virl_topology.png)

_The default username/password is `admin/admin`_

## Build Topology

_NOTE: The Topology requires images for vmanage, vbond, vsmart, vedge, and CSR1000v_

### Step1

Cloning the workshop repo repo:

``` shell
git clone https://wwwin-github.cisco.com/ciscops/ps-crn.git --recursive
```
>For more help with git, see DevNet's [A Brief Introduction to Git](https://learninglabs.cisco.com/lab/git-basic-workflows/step/1)

### Step 2

Navigate to the `ps-crn` directory.

``` shell
$ cd ps-crn/
```

>Note: All subsequent exercises will be in this directory unless otherwise noted.

### Step 3

Install requirements with pip:

```
pip install -r requirements.txt
```

Install sshpass (see [pre-requisites](../../pre-requisites.md)).

### Step 4

Deploy Topology:

Create a file named `.virlrc` in the `ps-crn` directory:
``` shell
VIRL_USERNAME=guest
VIRL_PASSWORD=guest
VIRL_HOST=your.virl.server
```

>Note: your values will be different.

Run the `build` playbook to the build the topology:
``` shell
ansible-playbook build.yml
```

>Note: The username is used in the session ID by default.  A different tag can be specified by adding `-e virl_tag=<tag name>`.

This playbook will:
* Launch the topology file
* Wait until they show as reachable in VIRL

## Configure the Topology

### Requirements

* A license file located at `licenses\viptela_serial_file.viptela`
* The organization name associated with the license file.

>Note: You'll need to create the `licenses` directory in the `ps-crn` directory
### Step 1

The easiest way to specify the organization name is to modify `organization_name` in `inventory/group_vars/all/viptela.yml`:

```shell
organization_name: ""
```

Now run `configure.yml` running only those plays with the tag `control`:

```shell
ansible-playbook configure.yml --tags=control
```

Alternatively, organization name can be passed in as an extra var (**note commas**): 

```shell
ansible-playbook configure.yml -e 'organization_name="<your org name>"' --tags=control
```

`configure.yml` can also be run with the following tags:
* `CA`: only create the private CA
* `control`: only provision the Viptela control plane
* `vedge`: only provision the Viptela vEdges
* `check_control`: check connectivity of the control plane
* `check_edge`: check connectivity of the edge
* `check_all`: check full connectivity of the overlay

This playbook will:
* Check for the existance of the license file
* Check initial connectivity
* Generate a local CA
* Configure all Viptela elements
* Create CSR, sign CSR, and install certificate
* Add vbond and vsmart to vmanage

### Step 2

Verify just the control plane by using the `check_control` tag:

```shell
ansible-playbook configure.yml --tags=check_control
```

### Import the Templates
```yaml
ansible-playbook import_templates.yml
```
### Apply the Templates
```yaml
ansible-playbook attach_templates.yml
```
## Clean the topology

### Step 1

Now that we are done with the workshop, let's clean up the environment:

```shell
ansible-playbook clean.yml
```

This playbook will:
* Remove topology devices from the `known_hosts` file
* Remove the `myCA` directory
* Destroy the topology specified in `.virl/default/id`
---