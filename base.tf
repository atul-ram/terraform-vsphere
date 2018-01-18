provider "vsphere" {
	user = "demouser@dcloud.cisco.com"
	password ="C1sco12345"
	vsphere_server = "vc1.dcloud.cisco.com"
	allow_unverified_ssl= true
	}


data "vsphere_datacenter" "dc" {}

data "vsphere_datastore" "datastore" {
  name          = "Datastore_NFS"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "dCloud-DC/Resources"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_folder" "TerraformFrontEnd" {
      datacenter_id = "${data.vsphere_datacenter.dc.id}"
      path = "TerraformFrontEnd"
      type          = "vm"
}

data "vsphere_virtual_machine" "template" {
  name          = "centos7-worker"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
		  
data "vsphere_network" "network" {
  name          = ""
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


resource "vsphere_virtual_machine" "vm" {
  name             = "terraform-test"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 2
  memory   = 4096
  guest_id = "centos7guest"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    name = "terraform-test.vmdk"
    size = 20
  }
}
