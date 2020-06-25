#!/bin/sh

if [ -z "$1" ]; then 
    echo "Falta parametro para correr el script (nombre del archivo con el fullchain)"
    echo "k8s-update-cert.sh <nombre del fullchain.pem>"
    exit -1;
fi



echo "Creando ca.crt en base a $1"
openssl x509 -outform der -in certs/$1 -out certs/ca.crt

echo "Incorporando ca.crt al secret ingress-cert"
# CA_CRT=$(cat certs/ca.crt | base64 | sed 's/[\\&*./+!]/\\&/g' )

cat > template/01-update-secret.yaml <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: ingress-cert
  namespace: dcm4che
type: Opaque
data:
  ca.crt: $(cat certs/ca.crt | base64 | tr -d '\n')
EOF

# echo "Generando manifiesto de secret ingress-cert"
# sed `s/{{CERT}}/$CA_CRT/g` template/01-update-secret.tpl > template/01-update-secret.yaml

echo "Aplicando manifiesto"
#kubectl apply -f 01-update-secret.yaml

docker run --rm --name kubectl -v $PWD/kubeconfig:/.kube/config -v $PWD/template/01-update-secret.yaml:/01-update-secret.yaml bitnami/kubectl:1.16.3 apply -f 01-update-secret.yaml
