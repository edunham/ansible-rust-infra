# Ansible Rust Infrastructure

See [here](http://edunham.net/2015/06/05/configuration_management_comparison.html)
for a detailed explanation of why I chose Ansible.

You need to have Ansible installed, and SSH access to the machine you wish to
configure. Ansible can come from your system's package manager or `pip install
ansible`. 

Some roles from the Galaxy are used. To install them, 

```
$ ansible-galaxy install --force -r galaxy_roles.yaml
```

To play with a toy local copy of the roles, a Vagrantfile is included. Install
`virtualbox` and `vagrant` on your system, then

```
$ vagrant up thing
$ vagrant provision thing
```

where `thing` is the nickname of the host you wish to play with. The
`Vagrantfile` and `vagrant.yaml` control which roles apply to which hosts. 
