# store

This is an example Ansible project that performs a set of use cases on a two node virtualization cluster.

The following playbooks are implemented:

* `status.yml` : Displays the current cluster status from `pcs status`
* `setup.yml` : Deploys and configures pacemaker and libvirt on the hosts in the "cluster_nodes" group
* `vm_deploy.yml` : Deploys a virtual machine onto the cluster
* `vm_delete.yml` : Deletes a virtual machine from the cluster

Examples:

`ansible-playbook -i hosts setup.yml`

Installs and configures the cluster.

`ansible-playbook -i hosts status.yml`

Show the current cluster status.

`ansible-playbook -e 'vm_name=db' -i hosts vm_deploy.yml`

Deploys a virtual machine named "db" onto the cluster.

`ansible-playbook -e 'vm_name=db' -i hosts vm_delete.yml`

Deletes a virtual machine named "db" from the cluster.

Configuration is in `group_vars/all` - add your satellite registration, nfs, and other information in there.

A number of assumptions are made about the environment currently:
* Systems will be registered to Satellite 6
* Storage is on NFS and guests are stored in a directory called "guests" within the NFS volume.
