# -*- mode: ruby -*-
# vi: set ft=ruby :

# The "2" is Vagrant API/syntax version. Don't touch.
Vagrant.configure(2) do |config|
  # https://atlas.hashicorp.com/search.
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  #config.vm.network :public_network
  config.vm.define "bastion" do |bastion|
    bastion.vm.provision "ansible" do |ansible|
        ansible.playbook = "vagrant.yaml"
        ansible.sudo = true
    end
  end
  config.vm.define "proxy" do |proxy|
    proxy.vm.provision "ansible" do |ansible|
        ansible.playbook = "vagrant.yaml"
        ansible.sudo = true
    end
  end
  config.vm.define "buildmaster" do |buildmaster|
    buildmaster.vm.provision "ansible" do |ansible|
        ansible.playbook = "vagrant.yaml"
        ansible.sudo = true
    end
  end
  config.vm.define "elk" do |elk|
    elk.vm.provision "ansible" do |ansible|
        ansible.playbook = "vagrant.yaml"
        ansible.sudo = true
    elk.vm.network :forwarded_port, guest: 80, host: 5432
    elk.vm.network :forwarded_port, guest: 5601, host:5601
    end
  end
  config.vm.define "ndk" do |ndk|
    ndk.vm.provision "ansible" do |ansible|
        ansible.playbook = "vagrant.yaml"
        ansible.sudo = true
    end
  end
end
