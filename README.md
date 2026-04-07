# terraform-cicd-templates

Reusable GitHub Actions workflows for all Terraform module repos
in this org.

## How to Use

### 1. CI on Pull Requests
Create `.github/workflows/ci.yml` in your module repo:
`````yaml
name: CI
on:
  pull_request:
    branches: [main]
jobs:
  terraform-ci:
    uses: YOUR-ORG/terraform-cicd-templates/.github/workflows/terraform-ci.yml@main
    with:
      terraform_version: '1.6.0'
\```

### 2. Release on Tag Push
Create `.github/workflows/release.yml` in your module repo:
````yaml
name: Release
on:
  push:
    tags:
      - 'v*.*.*'
jobs:
  terraform-release:
    uses: YOUR-ORG/terraform-cicd-templates/.github/workflows/terraform-release.yml@main
    with:
      terraform_version: '1.6.0'
    secrets:
      github_token: ${{ secrets.GITHUB_TOKEN }}
\```

### 3. Tagging a Release
```bash
git tag v1.0.0
git push origin v1.0.0
\```
```

---

## Step 5 — Push to GitHub
```bash
git clone https://github.com/YOUR-ORG/terraform-cicd-templates
cd terraform-cicd-templates

mkdir -p .github/workflows

# create the files above, then:
git add .
git commit -m "feat: add reusable CI and release workflows"
git push origin main
```

---

## What Each Module Repo Needs (just 2 files!)
```yaml
# .github/workflows/ci.yml
name: CI
on:
  pull_request:
    branches: [main]
jobs:
  terraform-ci:
    uses: YOUR-ORG/terraform-cicd-templates/.github/workflows/terraform-ci.yml@main
    with:
      terraform_version: '1.6.0'
```
```yaml
# .github/workflows/release.yml
name: Release
on:
  push:
    tags:
      - 'v*.*.*'
jobs:
  terraform-release:
    uses: YOUR-ORG/terraform-cicd-templates/.github/workflows/terraform-release.yml@main
    with:
      terraform_version: '1.6.0'
    secrets:
      github_token: ${{ secrets.GITHUB_TOKEN }}
```

---

Once you've pushed `terraform-cicd-templates`, come back and I'll help you add the module code and wire up the workflows in each module repo!