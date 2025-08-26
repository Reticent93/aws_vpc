variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
}


variable "project_name" {
    description = "Name of the project"
    type        = string
}

variable "security_group_rules" {
    description = "Security group rules for VPCs"
    type = object({
        web_ingress_ports = list(number)
        ssh_cidr_blocks   = list(string)
        egress_all        = bool
    })
    default = {
        web_ingress_ports = [80, 443]
        ssh_cidr_blocks   = ["10.0.0.0/8"]
        egress_all        = true
    }
}

variable "vpc_peering" {
    description = "VPC peering configuration"
    type = object({
        peer_vpc_id = string
        auto_accept = bool
    })
    default = {
        peer_vpc_id = ""
        auto_accept = false
    }
}