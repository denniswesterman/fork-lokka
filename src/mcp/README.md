# Lokka - MCP Server for Azure and Microsoft Graph

Lokka is an MCP server for querying and managing your Azure and Microsoft 365 tenants using the Microsoft Azure/Graph APIs. It acts as a bridge between the Microsoft APIs and any compatible MCP client, allowing you to interact with your Azure and Microsoft 365 tenant using natural language queries.

## Sample queries

Here are some examples of queries you can use with Lokka.

- `Create a new security group called 'Sales and HR' with a dynamic rule based on the department attribute.`
- `Find all the conditional access policies that haven't excluded the emergency access account`
- `Show me all the device configuration policies assigned to the 'Call center' group`

## What is Lokka?

Lokka is designed to be used with any compatible MCP client, such as Claude Desktop, Cursor, Goose, or any other AI model and client that support the Model Context Protocol. It provides a simple and intuitive way to manage your Azure and Microsoft 365 tenant using natural language queries.

Follow the guide at [Lokka.dev](https://lokka.dev) to get started with Lokka and learn how to use it with your favorite AI model and chat client.

![How does Lokka work?](https://github.com/merill/lokka/blob/main/website/docs/assets/how-does-lokka-mcp-server-work.png?raw=true)

## MCP Client Configuration

### Option 1: Client Secret Authentication (Legacy)

```json
{
  "mcpServers": {
    "Lokka-Microsoft": {
      "command": "npx",
      "args": ["-y", "@merill/lokka"],
      "env": {
        "TENANT_ID": "<tenant-id>",
        "CLIENT_ID": "<client-id>",
        "CLIENT_SECRET": "<client-secret>"
      }
    }
  }
}
```

### Option 2: Certificate-based Authentication (Recommended)

```json
{
  "mcpServers": {
    "Lokka-Microsoft": {
      "command": "npx",
      "args": ["-y", "@merill/lokka"],
      "env": {
        "TENANT_ID": "<tenant-id>",
        "CLIENT_ID": "<client-id>",
        "AZURE_CLIENT_CERTIFICATE_PATH": "<path-to-certificate-file>",
        "AZURE_CLIENT_CERTIFICATE_PASSWORD": "<certificate-password-if-any>"
      }
    }
  }
}
```

### Option 3: Azure CLI Authentication (For Development)

```json
{
  "mcpServers": {
    "Lokka-Microsoft": {
      "command": "npx",
      "args": ["-y", "@merill/lokka"],
      "env": {}
    }
  }
}
```

Then run: `az login` in your terminal before starting your MCP client.

## Certificate-Based Authentication Setup

1. Create a certificate and register it with your Azure AD application:
   
   ```powershell
   # Generate a self-signed certificate with PowerShell
   $certName = "LokkaAppCert"
   $cert = New-SelfSignedCertificate -Subject "CN=$certName" -CertStoreLocation "Cert:\CurrentUser\My" -KeyExportPolicy Exportable -KeySpec Signature -KeyLength 2048 -KeyAlgorithm RSA -HashAlgorithm SHA256
   
   # Export the certificate as PFX (with private key)
   $password = ConvertTo-SecureString -String "YourStrongPassword" -Force -AsPlainText
   $certPath = "$env:USERPROFILE\$certName.pfx"
   Export-PfxCertificate -Cert "Cert:\CurrentUser\My\$($cert.Thumbprint)" -FilePath $certPath -Password $password
   
   # Export public key for Azure AD registration
   $certPathCer = "$env:USERPROFILE\$certName.cer"
   Export-Certificate -Cert "Cert:\CurrentUser\My\$($cert.Thumbprint)" -FilePath $certPathCer
   ```

2. Register the certificate with your Azure AD application:
   
   - Go to Azure Portal -> Azure Active Directory -> App Registrations
   - Find and select your application
   - Go to "Certificates & secrets"
   - Click "Upload certificate" and upload the .cer file (public key)

3. Set the environment variables in your MCP client configuration:
   ```
   TENANT_ID: Your Azure AD tenant ID
   CLIENT_ID: Your Azure AD application ID
   AZURE_CLIENT_CERTIFICATE_PATH: Full path to your .pfx certificate file
   AZURE_CLIENT_CERTIFICATE_PASSWORD: The password you set when exporting the certificate
   ```

## Get started

See the docs for more information on how to install and configure Lokka.

- [Introduction](https://lokka.dev/docs/intro)
- [Install guide](https://lokka.dev/docs/installation)
- [Developer guide](https://lokka.dev/docs/developer-guide)
