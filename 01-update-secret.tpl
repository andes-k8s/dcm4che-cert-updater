---
apiVersion: v1
kind: Secret
metadata:
  name: ingress-cert
  namespace: dcm4che
type: Opaque
data:
  ca.crt: {{CERT}}
