/* main.tf
   Alta3 Research - rzfeeser@alta3.com */

# interact with docker
provider "docker" {}

# create random_ resources
provider "random" {}

# interact with time data
provider "time" {}

resource "docker_image" "nginx" {
  name         = "nginx:1.23.4"
  keep_locally = true
}

# available from random.random_pet
resource "random_pet" "nginx" {
  length = 2
  #loop_id = var.loop_id
}

resource "docker_container" "nginx" {
  count = 4
  image = docker_image.nginx.image_id
  name  = "nginx-${random_pet.nginx.id}-${count.index}"
  # name = "nginx-hoppy-frog-0"
  #loop = random_pet.nginx.loop_id

  ports {
    internal = 80
    # 8000, 8001, 8002, 8003
    external = 8000 + count.index
  }
}
