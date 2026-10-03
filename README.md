# Infraestructura con Terraform y Docker

Este proyecto despliega dos entornos aislados (DEV y QA) utilizando contenedores Docker orquestados mediante Terraform.

## Requisitos previos
- Docker instalado y ejecutándose.
- Terraform instalado.

## Instrucciones de despliegue

1. Clona o descarga este repositorio y abre una terminal en la raíz del proyecto.
2. Descarga los proveedores necesarios ejecutando:
   `terraform init`
3. Revisa los recursos que se van a crear ejecutando:
   `terraform plan`
4. Construye la infraestructura ejecutando:
   `terraform apply -auto-approve`
5. Para eliminar todos los recursos creados, ejecuta:
   `terraform destroy -auto-approve`