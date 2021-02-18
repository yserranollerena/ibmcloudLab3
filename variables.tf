variable "ibmcloud_api_key" {
    default = ""
    description = "Requerido para crear componentes"
}

variable "organization" {
    default = ""
    description = "Nombre de la organización cloud foundry"
}
variable "environment" {
    default = ""
    description = "Nombre de su espacio de cloud foundry"
}