##Variables para instancias
ami                         = "ami-007855ac798b5175e"
instance_type               = "t2.micro"
key_pair_name               = "vockey"
connection_type             = "ssh"
username                    = "ubuntu"
private_key_file_location   = "./vockey.pem"

##Variables para networking
rango_ip_vpc    = "10.0.0.0/22"
igw_name        = "igw-practico-3tier"
rt_name         = "rt-practico-3tier"
vpc_name        = "vpc-practico-3tier"

##Variables para seguridad

##Variables para bases de datos
rds_user            = "aplicacion"
rds_password        = "Apl1c4tiv*"
rds_dbname          = "idukan"