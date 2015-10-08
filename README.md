# Ansible Rust Infrastructure ![build status](https://travis-ci.org/edunham/ansible-rust-infra.svg)

See [here](http://edunham.net/2015/06/05/configuration_management_comparison.html)
for a detailed explanation of why I chose Ansible.

### Setting Up

You need to have Ansible installed, and SSH access to the machine you wish to
configure. Ansible can come from your system's package manager or `pip install
ansible`. 

If you don't want to install `ansible` system-wide, you can `pip install
pip_requirements.txt` into a local virtualenv. 

### Install Galaxy roles

The Ansible Galaxy is a site which aggregates open source Ansible roles for
common tasks. You can install Galaxy roles in a number of ways, but for this
repo, use

```
$ ansible-galaxy install --force -r galaxy_roles.yaml
```

The `galaxy_roles.yaml` file specifies the exact version of each role to check
out, so that new developments to the roles can be checked for unexpected
behavior before we start using them. 

### Using Virtualbox

To play with a toy local copy of the roles, a Vagrantfile is included. Install
`virtualbox` and `vagrant` on your system, then

```
$ vagrant up rolename
$ vagrant provision rolename
```

where `thing` is the nickname of the host you wish to play with. The
`Vagrantfile` and `vagrant.yaml` control which roles apply to which hosts. 

### Provisioning Production 

My current workflow is to run Ansible from the Bastion host when managing
production systems. I've added the alias `suansible` to the Bastion's ubuntu
user, which switches to the ansible user while carrying your `SSH_AUTH_SOCK`
if you logged in with `ssh -A bastion`, and the `ansible` user's `.bashrc`
automatically activates a virtualenv with Ansible installed and changes to the
`ansible-rust-infra` directory when you log in.  

```
$ ssh bastion
$ suansible
$ git pull
$ ansible-playbook provision/<host> --check # dry-run to see what would change
$ ansible-playbook provision/<host>         # Actually make changes
```

