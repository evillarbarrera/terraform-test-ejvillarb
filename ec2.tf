variable "instancias" {
  description = "Nombre de las intancias"
  type = list(string)
  default = [ "apache" ]
  
}


resource "aws_instance" "public_instance" {
  for_each                = toset(var.instancias)
  ami                     = var.ec2_specs.ami //"ami-04cb4ca688797756f"
  instance_type           = var.ec2_specs.instance_type //"t2.micro"
  subnet_id               = aws_subnet.public_subnet.id
  key_name                = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [ aws_security_group.security_public_instance.id ]
  user_data              = file("scripts/userdata.sh")

  tags = {
    # "Name" = var.instancias[count.index]
    "Name" = "${each.value}-${local.sufix}"
  }

  # provisioner "local-exec" {
  #   command = "echo instancia creada con IP ${aws_instance.public_instance.public_ip} >> datos_instancia.txt"

  # }

  # provisioner "local-exec" {
  #   when = destroy
  #   command = "echo instancia creada con IP ${self.public_ip} destruida >> datos_instancia.txt"
    
  # }
  # lifecycle {
  #   create_before_destroy = false // crear antes de destruir en este caso la instancia
  #   prevent_destroy = true // da error si la quieres destruir.ignore_changes = [  ]
  #   # ignore_changes = [ ami ] //ignora cualquier cambio de las variables.
  #   replace_triggered_by = [ aws_subnet.private_subnet ] // cuando cambie algun recurso mencionado la instancia realizara un replace.
  # }


}

resource "aws_instance" "monitoring_instance" {
  # count                   = var.enable_monitoring ? 1:0
  count                   = var.enable_monitoring == 1 ? 1 : 0
  ami                     = var.ec2_specs.ami //"ami-04cb4ca688797756f"
  instance_type           = var.ec2_specs.instance_type //"t2.micro"
  subnet_id               = aws_subnet.public_subnet.id
  key_name                = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [ aws_security_group.security_public_instance.id ]
  user_data              = file("scripts/userdata.sh")

  tags = {
    "Name" = "Monitoreo-${local.sufix}"
  }

}