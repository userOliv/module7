terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.89.0"
    }
  }
   backend "azurerm" {  # kopierer tfstate file til azure container
 resource_group_name  =  "rg1we1modu61"
 storage_account_name =  "sa1wemod62"
    container_name       = "ct1we1mod61"
    key                  = "Dev7.terraform.tfstate"  # navn til tfstate i azure container
  }
}

/*provider "azurerm" {
  features { }
}*/


provider "azurerm"{
  features {
key_vault {
  purge_soft_delete_on_destroy = true
  recover_soft_deleted_keys = true
}
    
  } 
}