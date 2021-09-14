terraform {
    required_providers {
        linode = {
            source  = "linode/linode"
            version = "1.16.0"
        }
    }
}

provider "linode" {
    token = var.token
}

resource "linode_instance" "vpn-server" {
    label           = var.name
    image           = var.image
    region          = var.region
    type            = var.type
    authorized_keys = values(var.public_keys)

    provisioner "remote-exec" {
        inline = [
            "sudo apt update",
            "sudo apt install python3 -y"
        ]

        connection {
            host        = self.ip_address
            type        = "ssh"
            user        = "root"
            private_key = file(var.pvt_key)
        }
    }

    provisioner "local-exec" {
        command = <<-EOT
            mkdir ~/tmp
            mkdir ~/tmp/${var.name}
            curl https://raw.githubusercontent.com/Dekamik/vpn-modules/main/vpn-server/ovpn-install.yml > ~/tmp/${var.name}/ovpn-install.yml
            ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ip_address},' --private-key ${var.pvt_key} -e 'server_name=${var.name} dl_dir=${var.download_dir}' ~/tmp/${var.name}/ovpn-install.yml
            rm -rf ~/tmp/${var.name}
            find ~/tmp -maxdepth 0 -empty -exec rmdir ~/tmp \;
        EOT
    }
}
