# -*- mode: ruby -*-
# vim: set ft=ruby :
disk_controller = 'SATA Controller'

MACHINES = {
  :zfs => {
    :box_name => "centos/7",
    :box_version => "2004.01",
    :provision => "test.sh",
    :disks => (1..8).map { |i| { :name => "disk#{i}_#{Time.now.to_i}.vdi", :size => 512, :controller => disk_controller } }
  }
}

Vagrant.configure("2") do |config|
  MACHINES.each do |name, boxconfig|
    config.vm.define name do |box|
      box.vm.box = boxconfig[:box_name]
      box.vm.box_version = boxconfig[:box_version]

      box.vm.provider :virtualbox do |vb|
        # Создаем контроллер SATA
        vb.customize ['storagectl', :id, '--name', disk_controller, '--add', 'sata', '--controller', 'IntelAHCI']

        # Создаем и подключаем диски
        boxconfig[:disks].each_with_index do |disk, index|
          vb.customize ['createhd', '--filename', disk[:name], '--size', disk[:size]]
          vb.customize ['storageattach', :id, '--storagectl', disk[:controller], '--port', index, '--device', 0, '--type', 'hdd', '--medium', disk[:name]]
        end
      end
      
      box.vm.provision "shell", path: boxconfig[:provision]
    end
  end
end
