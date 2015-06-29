# toy-ansible

I've been nerd-sniped by Ansible's paradigms, so I'm playing with some
configs. If all goes well, this repo will end up containing an approximate
copy of the Rust project's infrastructure, since that's what I'm currently
seeking the ideal tool for.

## The Infrastructure

This infrastructure consists of a bastion server, an nginx proxy, the
playground, a Buildbot buildmaster, and a variety of Buildbot workers. 

### Bastion

Essential: 

- [ ] Users whose SSH pubkeys are present on the host can log in
- [ ] Users can SSH from Bastion to other hosts (handled by AWS firewall)

Nice-to-have: 

- [ ] MOTD reminds users how to use Bastion correctly
- [ ] An intrusion detection system reports unusual activity to administrators
- [ ] All connections into and out of Bastion are logged (logs immutable to
  users)
- [ ] Homedirs are forcibly emptied on a regular basis (make bad practices
  difficult)

### Nginx Proxy

Essential: 

- [x] Nginx is installed and configuration files from current system are in
  place
- [x] Nginx reloads when changes to its configs are pushed
- [x] A unique Diffie-Hellman group is generated for SSL (https://weakdh.org/)
- [ ] A self-signed SSL cert is generated on the host

Nice-to-have: 

- [ ] Nginx logs go somewhere useful to be graphed
- [ ] Nginx errors and warnings are sent as alerts to the sysadmin (`\o`)
- [ ] Something alerts the sysadmin if config mgmt found any config file had
  been modified on the system since its last run
- [ ] Our real SSL cert is encrypted in the repo and decrypted on the host

### Playground

Essential: 

- [x] `playpen` is installed
- [ ] `rust-playpen` is installed
- [ ] irc bot is running
- [ ] web server is running
- [ ] bitly api key encrypted in config mgmt and decrypted when host deployed

Nice-to-have:

- [ ] refactor playground to use containers for sandboxing
- [ ] lock down AWS firewall to prevent connections between playground and
  hosts other than Bastion

### Buildmaster

Essential: 

- [ ] Buildbot is installed and its configurations are in place
- [ ] GitHub and other bot integration is configured

Nice-to-have: 

- [ ] TaskCluster

### Build Workers

Essential: 

- [ ] Configured as Buildbot slaves as per https://github.com/rust-lang/rust-buildbot
- [ ] At least one distro of Linux buildslave in config mgmt

Nice-To-Have: 

- [ ] Automatically deployed from premade images
- [ ] Ccache to eliminate spurious LLVM compiles
- [ ] config mgmt for all supported Linux distros, Mac & Windows
- [ ] Buildbot refactored to not call them slaves
- [ ] metrics on worker instance utilization
