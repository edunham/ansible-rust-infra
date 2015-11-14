# -*- mode: ruby -*-
# vi: set ft=ruby :

# The "2" is Vagrant API/syntax version. Don't touch.
Vagrant.configure(2) do |config|
  # https://atlas.hashicorp.com/search.
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  #config.vm.network :public_network
  config.vm.define "bastion" do |bastion|
    bastion.vm.provision "ansible" do |ansible|
        ansible.playbook = "provision/bastion.yaml"
        ansible.sudo = true
        ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
    end
  end
  config.vm.define "proxy" do |proxy|
    proxy.vm.provision "ansible" do |ansible|
        ansible.playbook = "provision/proxy.yaml"
        ansible.sudo = true
        ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
    end
  end
  config.vm.define "prodmaster" do |prodmaster|
    prodmaster.vm.provision "ansible" do |ansible|
        ansible.playbook = "provision/prodmaster.yaml"
        ansible.sudo = true
        ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
    end
  end
  config.vm.define "ndk" do |ndk|
    ndk.vm.provision "ansible" do |ansible|
        ansible.playbook = "provision/ndk.yaml"
        ansible.sudo = true
        ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
    end
  end
  config.vm.define "playground" do |playground|
    playground.vm.box = "arch"
    playground.vm.box_url = "http://cloud.terry.im/vagrant/archlinux-x86_64.box"
    playground.vm.provision "ansible" do |ansible|
      ansible.playbook = "provision/playground.yaml"
      ansible.sudo = true
      ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
    end
  end
end
