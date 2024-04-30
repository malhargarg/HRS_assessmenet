resource "aws_instance" "devops-bastion" {
  ami                    = lookup(var.AMIS, var.AWS_REGION)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.devopskey.key_name
  subnet_id              = module.vpc.public_subnets[0]
  count                  = var.instance_count
  vpc_security_group_ids = [aws_security_group.devops-bastion-sg.id]

  tags = {
    Name    = "devops-bastion"
    PROJECT = "devops"
  }

  provisioner "file" {
    content     = templatefile("templates/db-deploy.tmpl", { rds-endpoint = aws_db_instance.devops-rds.address, dbuser = var.dbuser, dbpass = var.dbpass })
    destination = "/tmp/devops-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/devops-dbdeploy.sh",
      "sudo /tmp/devops-dbdeploy.sh"
    ]
  }

  connection {
    user        = var.USERNAME
    private_key = file(var.PRIV_KEY_PATH)
    host        = self.public_ip
  }
  depends_on = [aws_db_instance.devops-rds]
}