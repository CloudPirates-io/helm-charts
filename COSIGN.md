# Cosign Signature Verification

All CloudPirates Helm charts are cryptographically signed using [Cosign](https://docs.sigstore.dev/cosign/) to ensure authenticity, integrity, and supply chain security. This document provides comprehensive guidance on verifying chart signatures.

## Overview

Every chart published to `registry-1.docker.io/cloudpirates/` is signed with our private key and can be verified using the corresponding public key. This ensures:

- **Authenticity**: Confirms charts are published by CloudPirates
- **Integrity**: Ensures charts haven't been tampered with since signing
- **Supply Chain Security**: Provides end-to-end verification of chart origins

## Public Key

All charts are signed with the following Cosign public key:

**Download:** [cosign.pub](https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/cosign.pub)

```
-----BEGIN PUBLIC KEY-----
MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE7BgqFgKdPtHdXz6OfYBklYwJgGWQ
mZzYz8qJ9r6QhF3NxK8rD2oG7Bk6nHJz7qWXhQoU2JvJdI3Zx9HGpLfKvw==
-----END PUBLIC KEY-----
```

## Manual Verification

### Prerequisites

Install Cosign on your system:

```bash
# macOS (using Homebrew)
brew install cosign

# Linux (using curl)
curl -O -L "https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64"
sudo mv cosign-linux-amd64 /usr/local/bin/cosign
sudo chmod +x /usr/local/bin/cosign

# Windows (using winget)
winget install sigstore.cosign
```

### Step-by-Step Verification

1. **Download the public key:**

   ```bash
   # Option 1: Download directly from GitHub
   curl -o cosign.pub https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/cosign.pub

   # Option 2: Create manually
   cat > cosign.pub << 'EOF'
   -----BEGIN PUBLIC KEY-----
   MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE7BgqFgKdPtHdXz6OfYBklYwJgGWQ
   mZzYz8qJ9r6QhF3NxK8rD2oG7Bk6nHJz7qWXhQoU2JvJdI3Zx9HGpLfKvw==
   -----END PUBLIC KEY-----
   EOF
   ```

2. **Verify a specific chart:**

   ```bash
   # Replace <chart-name> and <version> with actual values
   cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/<chart-name>:<version>

   # Examples:
   cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/clusterpirate:1.0.0
   cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/valkey:0.1.1
   cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/mariadb:0.1.0
   ```

3. **Successful verification output:**
   ```
   Verification for registry-1.docker.io/cloudpirates/clusterpirate:1.0.0 --
   The following checks were performed on each of these signatures:
     - The cosign claims were validated
     - Existence of the claims in the transparency log was verified offline
     - The signatures were verified against the specified public key
   ```

## Helm Integration

### Verify Before Installing

Always verify chart signatures before installation:

```bash
# 1. Verify the signature
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/clusterpirate:1.0.0

# 2. Only install after successful verification
helm install my-release oci://registry-1.docker.io/cloudpirates/clusterpirate --version 1.0.0
```

## Additional Resources

- [Sigstore Documentation](https://docs.sigstore.dev/)
- [Cosign Installation Guide](https://docs.sigstore.dev/cosign/installation)
- [Supply Chain Security Best Practices](https://slsa.dev/)
