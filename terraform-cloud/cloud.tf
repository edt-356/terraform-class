terraform {
  cloud {
    organization = "edt-356"

    workspaces {
      name = "my-example"
    }
  }
}