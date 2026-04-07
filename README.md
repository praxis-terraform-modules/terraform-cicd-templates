# terraform-cicd-templates

Reusable GitHub Actions workflows for all Terraform module repos
in the `praxis` org.

## Workflows Available

| Workflow | Purpose | Trigger |
|---|---|---|
| `terraform-ci.yml` | Validate modules | PR to main |
| `terraform-release.yml` | Release module | Tag push |
| `pr-title.yml` | Enforce commit format | PR opened/edited |
| `auto-tag.yml` | Auto version bump | Push to main |
| `stale.yml` | Clean up stale PRs | Scheduled |

## How to Use in a Module Repo

### `.github/workflows/ci.yml`
````yaml
name: CI
on:
  pull_request:
    branches: [main]
jobs:
  validate-title:
    uses: praxis/terraform-cicd-templates/.github/workflows/pr-title.yml@v1.0.0
  terraform-ci:
    uses: praxis/terraform-cicd-templates/.github/workflows/terraform-ci.yml@v1.0.0
    with:
      terraform_version: '1.6.0'
\```

### `.github/workflows/release.yml`
```yaml
name: Release
on:
  push:
    tags:
      - 'v*.*.*'
jobs:
  terraform-release:
    uses: praxis/terraform-cicd-templates/.github/workflows/terraform-release.yml@v1.0.0
    with:
      terraform_version: '1.6.0'
    secrets:
      github_token: ${{ secrets.GITHUB_TOKEN }}
\```

## Commit Message Format

| Message | Version Bump |
|---|---|
| `fix: description` | patch → v1.0.1 |
| `feat: description` | minor → v1.1.0 |
| `feat!: description` | major → v2.0.0 |
```

---

## Push to GitHub
```bash
cd terraform-cicd-templates

# remove old files
git rm .pre-commit-config.yaml
git mv .github/workflows/terrafom-ci.yml .github/workflows/terraform-ci.yml

# add new files
# (create the files above)

git add .
git commit -m "feat: add complete cicd template workflows"
git push origin main

# auto-tag will create v0.1.0 automatically ✅
```

Once pushed and auto-tagged, let me know and we'll move to setting up the module repos!