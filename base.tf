provider "vSphere" {
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
		  
