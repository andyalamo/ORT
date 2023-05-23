locals {
  webservers = {

    webserver_us_east_1a = {
        availability_zone = "us-east-1a"
        subnet_id         = module.Subnet["subnet_us_east_1a"].subnet_id
        instance_name     = "webapp-server01"
        inline_commands   = [
        "sudo apt-get update -y",
        "sudo apt-get install apache2 software-properties-common mysql-client -y",
        "sudo add-apt-repository ppa:ondrej/php -y",
        "sudo apt-get update -y",
        "sudo apt-get install php5.6 php5.6-mysql -y",
        "sudo a2enmod php5.6 ; sudo service apache2 restart",
        "sudo git -C /var/www/html/ clone https://github.com/mauricioamendola/simple-ecomme.git",
        "sudo rm -rf /var/www/html/simple-ecomme/config.php",
        "echo '<?php",
        "  ini_set(\"display_errors\", 1);",
        "  error_reporting(-1);",
        "  define(\"DB_HOST\", \"${aws_db_instance.db.address}\");",
        "  define(\"DB_USER\", \"${var.rds_user}\");",
        "  define(\"DB_PASSWORD\", \"${var.rds_password}\");",
        "  define(\"DB_DATABASE\", \"${var.rds_dbname}\");",
        "?>' | sudo tee /var/www/html/simple-ecomme/config.php",
        "wget https://raw.githubusercontent.com/mauricioamendola/simple-ecomme/master/dump.sql",
        "mysql -h ${aws_db_instance.db.address} -P ${aws_db_instance.db.port} -u ${var.rds_user} -p${var.rds_password} ${var.rds_dbname} < ./dump.sql"
        ]
    },

    webserver_us_east_1b = {
        availability_zone = "us-east-1b"
        subnet_id         = module.Subnet["subnet_us_east_1b"].subnet_id
        instance_name     = "webapp-server02"
        inline_commands   = [
        "sudo apt-get update -y",
        "sudo apt-get install apache2 software-properties-common mysql-client -y",
        "sudo add-apt-repository ppa:ondrej/php -y",
        "sudo apt-get update -y",
        "sudo apt-get install php5.6 php5.6-mysql -y",
        "sudo a2enmod php5.6 ; sudo service apache2 restart",
        "sudo git -C /var/www/html/ clone https://github.com/mauricioamendola/simple-ecomme.git",
        "sudo rm -rf /var/www/html/simple-ecomme/config.php",
        "echo '<?php",
        "  ini_set(\"display_errors\", 1);",
        "  error_reporting(-1);",
        "  define(\"DB_HOST\", \"${aws_db_instance.db.address}\");",
        "  define(\"DB_USER\", \"${var.rds_user}\");",
        "  define(\"DB_PASSWORD\", \"${var.rds_password}\");",
        "  define(\"DB_DATABASE\", \"${var.rds_dbname}\");",
        "?>' | sudo tee /var/www/html/simple-ecomme/config.php"
        ]
    }
  }

  subnets = {
    subnet_us_east_1a = {
      rango_ip                = "10.0.1.0/24"
      availability_zone       = "us-east-1a"
      public_ip_on_launch     = "true"
      subnet_name             = "subnet_us_east_1a" 
    },

    subnet_us_east_1b = {
      rango_ip              = "10.0.2.0/24"
      availability_zone     = "us-east-1b"
      public_ip_on_launch   = "true"
      subnet_name           = "subnet_us_east_1b"
    }

  }


  routes_association = {
    rt_subnet_us_east_1a = {
      subnet_id = module.Subnet["subnet_us_east_1a"].subnet_id
    },

    rt_subnet_us_east_1b = {
      subnet_id = module.Subnet["subnet_us_east_1b"].subnet_id
    }
    
  }
}