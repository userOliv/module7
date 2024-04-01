
 #Felles variabler
variable "rgName" {
  type        = string
  description = "ressource grp "
  default     = "rg7md7blobwe"

}


variable "location" {
  type        = string
  description = "ressource grp location"
  default     = "westeurope"

}


#Felles variabler
variable "blobname" {
  type        = string
  description = "container blob navn"
  default     =  "blb1-mod7-we"


}

variable "sa" {
  type        = string
  description = "storage account navn"
  default     =  "sa7web7we7"


}

variable "source_content"{
     type        = string
  description = "storage account navn"
  default     =  "first web side"



}