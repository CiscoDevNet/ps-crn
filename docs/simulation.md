# PS-CRN Simulation

This is Simulation compentent of the [Public Sector Cloud Read Network](crn_overview.md) DevOps bundle.  It consists of
a dynamically generated VIRL topology.

## Requirements

* [virlutils](https://github.com/CiscoDevNet/virlutils)
* [ansible-viptela](https://github.com/CiscoDevNet/ansible-viptela)
* A Viptela license file and the Organization name associated with that license file.  The Organization name should be provided where you see: `<your org name>`

## Topology

![Alt Text](images/virl_topology.png)

_The default username/password is `admin/admin`_

## Using the Topology
* [Building the topology](virl/build.md)
* [Operating the topology](virl/operate.md)
* [Cleaning the topology](virl/clean.md)