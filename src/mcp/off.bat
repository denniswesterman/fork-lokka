@echo off
set TENANT_ID=9c1911eb-e651-4d7c-b94d-89653240760c
set CLIENT_ID=58f02dfd-2878-4860-abe3-a9c45e5b7cd1
set AZURE_CLIENT_CERTIFICATE_PATH=C:\Users\Server\LokkaAppCert.pfx
set AZURE_CLIENT_CERTIFICATE_PASSWORD=YourStrongPassword
rem OR uncomment the next line for client secret authentication
rem set CLIENT_SECRET=your-client-secret

node build/main




