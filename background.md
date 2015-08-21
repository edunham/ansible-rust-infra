# Ansible Rust Infrastructure

See [here](http://edunham.net/2015/06/05/configuration_management_comparison.html)
for a detailed explanation of why I chose Ansible.

## The Infrastructure

This infrastructure consists of a bastion server, an nginx proxy, the
playground, a Buildbot buildmaster, and a variety of Buildbot workers.

### Bastion

Essential:

- [X] Users whose SSH pubkeys are present on the host can log in
- [X] Users can SSH from Bastion to other hosts (handled by AWS firewall)

Nice-to-have:

- [ ] MOTD reminds users how to use Bastion correctly
- [ ] An intrusion detection system reports unusual activity to administrators
- [ ] All connections into and out of Bastion are logged (logs immutable to
  users)
- [ ] Homedirs are forcibly emptied on a regular basis (make bad practices
  difficult)
- [x] SSH pubkeys are automatically acquired from github
- [ ] Former users are deprovisioned

Status:

It works. To get it into production, will need to sort out who needs accounts
and where their keys should come from.

### Nginx Proxy

Essential:

- [x] Nginx is installed and configuration files from current system are in
  place
- [x] Nginx reloads when changes to its configs are pushed
- [x] A unique Diffie-Hellman group is generated for SSL (https://weakdh.org/)
- [X] A self-signed SSL cert is generated on the host

Nice-to-have:

- [ ] Nginx logs go somewhere useful to be graphed
- [ ] Nginx errors and warnings are sent as alerts to the sysadmin (`\o`)
- [ ] Something alerts the sysadmin if config mgmt found any config file had
  been modified on the system since its last run
- [ ] Our real SSL cert is encrypted in the repo and decrypted on the host

Status:

It works. To get it into production, will need to add real SSL certs,
encrypted, to Ansible.

### Playground

Essential:

- [x] `playpen` is installed
- [X] `rust-playpen` is installed
- [ ] irc bot is running
- [ ] web server is running
- [ ] bitly api key encrypted in config mgmt and decrypted when host deployed

Nice-to-have:

- [ ] refactor playground to use containers for sandboxing
- [ ] lock down AWS firewall to prevent connections between playground and
  hosts other than Bastion

Status:

Debootstrap conversion needs to be tested. Security needs to be tested.
Correct solution here is probably just to dockerize it (ETA 1 month as a
background task).

### Buildmaster

Essential:

- [X] Buildbot is installed and its configurations are in place
- [ ] secret values are encrypted

Nice-to-have:

- [ ] TaskCluster

Status:

We're patching Buildbot. Why are we patching buildbot? For production
readiness, need to thoroughly test with new version of buildbot (Pip's
mismatches apt's, which is another issue).

### Build Workers

Essential:

- [X] Configured as Buildbot slaves as per https://github.com/rust-lang/rust-buildbot
- [X] At least one distro of Linux buildslave in config mgmt

Nice-To-Have:

- [ ] Automatically deployed from premade images
- [ ] Ccache to eliminate spurious LLVM compiles
- [ ] config mgmt for all supported Linux distros, Mac & Windows
- [ ] Buildbot refactored to not call them slaves
- [ ] metrics on worker instance utilization

Status:

Not thoroughly tested. For production readiness, should test on more platforms
and refactor to examine platform in configs. Managing build workers is
low-priority.

### Ansible Best Practices

Essential:

- [ ] Secret values encrypted with vault
- [X] Directory layout set up according to [best
  practices](https://docs.ansible.com/playbooks_best_practices.html)

Nice-to-have:

- [ ] Share reusable portions on Galaxy (or refactor to use shared code)
- [ ] Include tests (how does one even test configs?)

Status:

This repo just doesn't have any secrets in it right now. Directory structure
is close to how everyone else does it.
