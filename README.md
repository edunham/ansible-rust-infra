# Ansible Rust Infrastructure ![build status](https://travis-ci.org/edunham/ansible-rust-infra.svg)

See [here](http://edunham.net/2015/06/05/configuration_management_comparison.html)
for a detailed explanation of why I chose Ansible.

### Setting Up

You need to have Ansible installed, and SSH access to the machine you wish to
configure. Ansible can come from your system's package manager or `pip install
ansible`.

If you don't want to install `ansible` system-wide, you can `pip install
pip_requirements.txt` into a local virtualenv.

### Secrets files

If you're testing these configs locally and aren't using Virtualbox, copy
`hosts.example` to `hosts` and give it valid values for the IPs and passwords.

For each host that you want to provision, copy `host_vars/hostname.example` to
`host_vars/hostname` and edit it with the desired values for the secrets.

### Install Galaxy roles

The Ansible Galaxy is a site which aggregates open source Ansible roles for
common tasks. To get the roles we need:

```
ansible-rust-infra$ ansible-galaxy install --force -r galaxy_roles.yaml
```

The `galaxy_roles.yaml` file specifies the exact version of each role to check
out, so that new developments to the roles can be tested for unexpected
behavior before we start using them.

### Using Virtualbox

To play with a toy local copy of the roles, a Vagrantfile is included. Install
`virtualbox` and `vagrant` on your system, then

```
$ vagrant up rolename
$ vagrant provision rolename
```

where `rolename` is the nickname of the host you wish to play with. The
`Vagrantfile` and `vagrant.yaml` control which roles apply to which hosts.
Currently,the available roles that you can provision are:

* bastion
* proxy
* prodmaster
* playground
* ndk (experimental role for Android cross-compilation slave)

### Provisioning Production

My current workflow is to run Ansible from the Bastion host when managing
production systems. I've added the alias `suansible` to the Bastion's ubuntu
user, which switches to the ansible user while carrying your `SSH_AUTH_SOCK`
if you logged in with `ssh -A bastion`. The `ansible` user's `.bashrc`
automatically activates a virtualenv with Ansible installed and changes to the
`ansible-rust-infra` directory when you log in.

```
$ ssh bastion
$ suansible
$ git pull
$ ansible-playbook provision/<host>.yaml --check # dry-run to see what would change
$ ansible-playbook provision/<host>.yaml         # Actually make changes
```

To change the secrets that a host is provisioned with, edit the values in
`host_vars/rolename` . To change the address corresponding to a given host,
edit `hosts`. The `hosts` file and `host_vars` secrets are the only files
which should not be checked into Git.

Note that the buildmasters are split into "devmaster" and "prodmaster". Both
playbooks currently apply the same role, but use different sets of secrets.

