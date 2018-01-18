
# Configure the VMware vSphere Provider
provider "vsphere" {
    vsphere_server = "${var.vsphere_vcenter}"
    user = "${var.vsphere_user}"
    password = "${var.vsphere_password}"
    allow_unverified_ssl = true
}

#build centos-vm
resource "vsphere_virtual_machine" "centos-vm" {
    name   = "centos-vm"
    vcpu   = 2
    memory = 8192
    domain = "local.domain"
    datacenter = "${var.vsphere_datacenter}"
    cluster = "${var.vsphere_cluster}"

    # Define the Networking settings for the VM
    network_interface {
        label = "VM Network"
        ipv4_gateway = "198.18.0.1"
        ipv4_address = "198.18.0.12"
        ipv4_prefix_length = "24"
    }

    dns_servers = ["198.18.0.131", "8.8.8.8"]

    # Define the Disks and resources. The first disk should include the template.
    disk {
        template = "CentOS-7-worker"
        datastore = "virtual_machines"
        type ="thin"
    }

    # Define Time Zone
    time_zone = "America/Chicago"
}
