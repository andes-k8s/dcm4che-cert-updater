# Script de actualización de Certificados para DCM4Che

Se debe correr este script cada vez que se actualiza el certificado de let's encrypt en el Load Balancer.

## Configuración

Se debe incluir un archivo con nombre ```kubeconfig``` con el kube config necesario para aplicar los cambios en el servidor.

Se debe incluir el archivo que contiene el fullchain.pem en la carpeta de este script.

## Ejecución

```./k8s-update-cert.sh fullchain.pem```

Se puede sustituir fullchain.pem por el nombre del fullchain que corresponda (en caso que tenga otro nombre)