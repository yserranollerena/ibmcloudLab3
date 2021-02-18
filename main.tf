terraform {
     required_providers {
      ibm = {
        source = "IBM-Cloud/ibm"
        version = "1.20.0"
      }
     }
  }

provider "ibm" {
  generation       = "2"
  region           = "us-south"
  ibmcloud_api_key = var.ibmcloud_api_key
}

data "ibm_space" "spacedata" {
  org   = var.organization
  name  = var.environment
}

data "ibm_app_domain_shared" "domain" {
  name = "mybluemix.net"
}
/*
data "archive_file" "app" {
  type        = "zip"
  source_dir = "src"
  output_path = "app.zip"
}*/

resource "ibm_app_route" "approute-demo-001" {
  domain_guid = data.ibm_app_domain_shared.domain.id
  space_guid  = data.ibm_space.spacedata.id
  host        = "cf-demo-${var.environment}-001"
}

resource "ibm_app" "cf-demo-001" {
  name                 = "cf-demo-${var.environment}-001"
  space_guid           = data.ibm_space.spacedata.id
  app_path             = "app.zip"
  buildpack            = "python_buildpack"
  route_guid           = [ibm_app_route.approute-demo-001.id]
  app_version          = "1"
  instances            = 2
  tags                 = [var.environment]
}

