terraform {
  required_providers {
    random = {
      version = "~> 3.0"
    }
  }
}

provider "random" {}


resource "null_resource" "empty_space" {
    depends_on = [ random_password.password ]
    provisioner "local-exec" {
        command = <<EOT
            echo "db_password: '${random_password.password.result}'" > results.yml
        EOT
    }
}

resource "random_password" "password" {
  length = 16                      // required
  special = true                   // include special characters (defaults are: !@#$%&*()-_=+[]{}<>:?)
  override_special = "_%@"         // supply your own list of specials (overrides default special list)
}
