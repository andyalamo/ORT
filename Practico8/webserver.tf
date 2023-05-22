module "Webserver" {
    source = "./modulos/webserver"

    for_each = local.webservers

    ami                     = var.ami
    instance_type           = var.instance_type
    availability_zone       = each.value.availability_zone
    subnet_id               = each.value.subnet_id
    key_pair_name           = var.key_pair_name
    vpc_security_group_ids  = [aws_security_group.sg_webserver.id]

    connection_type             = var.connection_type
    username                    = var.username
    private_key_file_location   = var.private_key_file_location
    inline_commands             = each.value.inline_commands

    instance_name               = each.value.instance_name
    
    depends_on = [
        module.Subnet,
        aws_db_instance.db
    ]

}