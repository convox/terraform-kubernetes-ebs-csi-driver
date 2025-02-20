terraform {
  required_version = ">= 0.12.6"

  required_providers {
    kubernetes = ">= 2.35.1"
    aws        = ">= 4.23.0"
  }
}
