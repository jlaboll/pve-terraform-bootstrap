variable "pm_api_url" {
  default = "http://localhost:8006/api2/json"
}

variable "pm_api_token_id" {
  default = "terraform-prov@pve!token"
}

variable "pm_api_token_secret" {
  default = "your-token-secret"
}

variable "ssh_keys" {
  default = <<EOF
ssh-ed25519 AAAA...key1
EOF
}

variable "pm_dns" {
  default = "8.8.8.8"
}

variable "pm_ciuser" {
  default = "admin"
}

variable "pm_cipass" {
  default = "password"
}

variable "pm_ceph_nodes" {
  type = list(object({
    node = string
    node_name = string
    mac  = string
    ip0  = string
    ip1  = string
  }))
  default = [
    {
      node = "node1"
      node_name = "1.node1"
      mac  = "AA:BB:CC:DD:EE:FF"
      ip0  = "ip=192.168.100.49/24,gw=192.168.100.1"
      ip1  = "ip6=21:22:23:24::23/64,gw6=21:22:23:24::1"
    }
  ]
}

variable "pm_worker_nodes" {
  type = list(object({
    node = string
    node_name = string
    mac  = string
    ip0  = string
    ip1  = string
  }))
  default = [
    {
      node = "node1"
      node_name = "1.node1"
      mac  = "AA:BB:CC:DD:EE:FF"
      ip0  = "ip=192.168.100.49/24,gw=192.168.100.1"
      ip1  = "ip6=21:22:23:24:a3bb:ccff:fedd:eef1/64,gw6=21:22:23:24::1"
    }
  ]
}
