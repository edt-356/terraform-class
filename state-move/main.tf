/* Understanding Modules
   main.tf - part of the "root module", this file defines the provider and then reaches for a prebuilt solution, "module.my_container" */

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }
  }
}


resource "docker_image" "simplegoservice" {
  name         = "registry.gitlab.com/alta3/simplegoservice"
  keep_locally = true      // keep image after "destroy"
}


resource "docker_container" "simplegoservice" {
  image = docker_image.simplegoservice.image_id
  name = "simple_service"
  ports {
    internal = 9876
    external = 5432
  }
}


# the "module" block is reaching for a prebuilt solution
module "my_container" {
    source = "./my_modules/container_maker"                 # path to our child module "container_maker"
    container_name = var.container_name_from_root           # this value provided in the root will override the value for var.container_name within the child module
}
