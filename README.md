# 🛡️ Terraform Security & Compliance

Automated security scanning for Terraform infrastructure code using Checkov and tfsec. Every PR is scanned for misconfigurations before any infrastructure is deployed.

## What Gets Scanned

| Tool | Checks |
|------|--------|
| Checkov | 1000+ security & compliance policies |
| tfsec | Terraform-specific security rules |
| Terrascan | Regulatory compliance (CIS, SOC2) |

## Pipeline

```
PR Opened → GitHub Actions
                ├── Checkov Scan
                ├── tfsec Scan
                ├── Terrascan (CIS Benchmark)
                └── Block merge if CRITICAL issues found
```

## Run Locally

```bash
# Checkov
pip install checkov
checkov -d . --framework terraform

# tfsec
brew install tfsec
tfsec .
```

## Tech Stack
`Checkov` `tfsec` `Terrascan` `GitHub Actions` `Terraform`
