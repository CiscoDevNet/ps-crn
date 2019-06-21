# PS-CRN Simulation

This is Simulation compentent of the [Public Sector Cloud Read Network](crn_overview.md) DevOps bundle.  It consists of
a dynamically generated VIRL topology.

## Requirements

* [ansible-viptela](https://github.com/CiscoDevNet/ansible-viptela)
* [virlutils](https://github.com/CiscoDevNet/virlutils)(optional)
* A Viptela license file and the Organization name associated with that license file in `licenses/serialFile.viptela`.  The Organization name should be provided where you see: `<your org name>`
* A Cisco Smart License token that point to an account with ASAv licensing

> One method for configuring organization name and smart licensing token is to specify them in `inventory/group_vars/all/local.yml`:
```
organization_name: "<your org name>"
license_token: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

## Topology

![Alt Text](images/virl_topology.png)

> The default username/password for network devices is `admin/admin`

> The default username/password for the control and test nodes is `virl/admin`

## Using the Topology
* [Building the topology](virl/build.md)
* [Operating the topology](virl/operate.md)
* [Cleaning the topology](virl/clean.md)