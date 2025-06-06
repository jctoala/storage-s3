﻿## storage
Este proyecto utiliza Terraform para desplegar un bucket S3 en AWS, junto con las configuraciones necesarias para permitir el acceso desde Internet. Además, gestiona el almacenamiento de archivos y su organización mediante AWS Resource Groups.

# Recursos Implementados

Bucket S3: Se crea un bucket en AWS S3 para guardar recursos.

Política de Acceso: Se define una política IAM para permitir acceso desde Internet.

Bloqueo de Acceso Público: Se configura la seguridad del bucket. Permitir acceso a lectura y descarga.

Carga de Archivos: Se suben archivos estáticos como index.html, css/styles.css y images/mywebsite.png. Puedes modificarlo en la carpeta ./app/

Resource Group: Se agrupan recursos de almacenamiento mediante etiquetas.

# Estructura del proyecto

.
├── app/                            # Archivos a ser almacenados en S3, modifica que recursos quieres compartir.
├── main.tf                         # Configuración principal de Terraform
├── providers.tf                    # Configuración de AWS en Terraform
├── terraform.tfvars.sample         # Ejemplo de archivo de variables que debes configurar
└── variables.tf                    # Definición de variables usadas en Terraform
