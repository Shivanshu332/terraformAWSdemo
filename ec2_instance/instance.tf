data "aws_ami" "rhel" {
    most_recent = true

    filter {
        name   = "name"
        values = [ var.ami_name ]
    }

    filter {
        name   = "virtualization-type"
        values = [ var.virtualization_type ]
    }

    owners = ["309956199498"]
}

resource "aws_instance" "web_instance" {
    ami           = data.aws_ami.rhel.id
    instance_type = var.instance_type_public
    vpc_security_group_ids = [aws_security_group.webSG.id]
    subnet_id = aws_subnet.shiv_public_subnet.id
    user_data = file("${path.module}/userdata.sh")

    tags = {
        Name = var.instance_name_public
    }
}

resource "aws_instance" "web_instance2" {
    ami           = data.aws_ami.rhel.id
    instance_type = var.instance_type_private
    vpc_security_group_ids = [aws_security_group.webSG.id]
    subnet_id = aws_subnet.shiv_private_subnet.id
    user_data = file("${path.module}/userdata.sh")

    tags = {
        Name = var.instance_name_private
    }
}