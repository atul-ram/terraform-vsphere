provider "vSphere" {
	user = "demouser@dcloud.cisco.com"
	password ="C1sco12345"
	vsphere_server = "vc1.dcloud.cisco.com"
	allow_unverified_ssl= true
	}


data "vsphere_datacenter" "dc" {}

resource "vsphere_folder" "TerraformFrontEnd" {

      datacenter_id = "${data.vsphere_datacenter.dc.id}"
      path = "TerraformFrontEnd"
      type          = "vm"

          }


