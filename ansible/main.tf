resource "local_file" "foo" {
    content  = "foo!"
    filename = "${path.module}/sumit"
}

null_resource "provisioner" {
  connection {
    ... # set the connection parameters here
  }

  provisioner "remote-exec" {
    command = ["ansible-playbook -u root --private-key ${var.ssh_keyname} -i ${self.ipv4_address} first-playbook.yml -e 'email_id=${var.email_id}'"]
  }
}