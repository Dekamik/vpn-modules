variable "token" {
    description = "Your Linode API token used to access your resources at Linode."
    type        = string
}

variable "pvt_key" {
    description = "Path to your private SSH key file."
    type        = string
    default     = "~/.ssh/id_rsa"
}

variable "download_dir" {
    description = "Path to a directory on your coputer to which all VPN-client files will be downloaded."
    type        = string
    default     = "~/vpn/"
}

variable "public_keys" {
    description = "A map of public ssh keys to add to authorized_keys on your VPN-servers."
    type        = map
}

variable "name" {
    description = "Linode instance name"
    type        = string
}

variable "region" {
    description = "Linode region"
    type        = string
}

variable "type" {
    description = "Linode instance type"
    type        = string
    default     = "g6-nanode-1"
}

variable "image" {
    description = "Linode instance image"
    type        = string
    default     = "linode/ubuntu20.04"
}
