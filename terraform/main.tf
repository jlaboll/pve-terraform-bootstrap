
resource "proxmox_vm_qemu" "ceph_nodes" {
  count       = length(var.pm_ceph_nodes)
  name        = "${var.pm_ceph_nodes[count.index].node_name}"
  target_node = "${var.pm_ceph_nodes[count.index].node}"

  clone = "ubuntu-2204-cloudinit-template"

  os_type  = "cloud-init"
  cores    = 2
  sockets  = "2"
  cpu      = "host"
  memory   = 20480
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    size     = "45G"
    type     = "scsi"
    storage  = "pve2"
    iothread = 1
  }

  disk {
    size     = "450G"
    type     = "scsi"
    storage  = "ceph${count.index}"
    iothread = 1
  }

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    macaddr = var.pm_ceph_nodes[count.index].mac
  }

  ipconfig0  = "${var.pm_ceph_nodes[count.index].ip0},${var.pm_ceph_nodes[count.index].ip1}"
  sshkeys    = var.ssh_keys
  ciuser     = var.pm_ciuser
  cipassword = var.pm_cipass
  nameserver = var.pm_dns
}

resource "proxmox_vm_qemu" "worker_nodes" {
  count       = length(var.pm_worker_nodes)
  name        = "${var.pm_worker_nodes[count.index].node_name}"
  target_node = "${var.pm_worker_nodes[count.index].node}"

  clone = "ubuntu-2204-cloudinit-template"

  os_type  = "cloud-init"
  cores    = 2
  sockets  = "2"
  cpu      = "host"
  memory   = 20480
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    size     = "45G"
    type     = "scsi"
    storage  = "pve2"
    iothread = 1
  }

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    macaddr = var.pm_worker_nodes[count.index].mac
  }

  ipconfig0  = "${var.pm_worker_nodes[count.index].ip0},${var.pm_worker_nodes[count.index].ip1}"
  sshkeys    = var.ssh_keys
  ciuser     = var.pm_ciuser
  cipassword = var.pm_cipass
  nameserver = var.pm_dns
}
