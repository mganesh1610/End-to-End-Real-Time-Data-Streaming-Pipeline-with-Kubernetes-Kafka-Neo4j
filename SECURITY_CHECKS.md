# Security checks

## Local checks

Install GitLeaks and pre-commit, then run `pre-commit install` in this checkout. The hook checks staged changes using the default GitLeaks rules plus the repository's Neo4j password rule in `.gitleaks.toml`. To scan all Git history, run:

```sh
gitleaks git --log-opts=--all --config=.gitleaks.toml --redact=100 --log-level=error
```

To inspect dependency and Kubernetes configuration issues, run:

```sh
trivy fs --scanners vuln,misconfig --severity HIGH,CRITICAL .
```

Before shipping a change, use [SECURITY_REVIEW_PROMPT.md](SECURITY_REVIEW_PROMPT.md) with an AI reviewer or a human reviewer and verify each reported code path.

## Pull requests

The Security review workflow runs GitLeaks and Trivy on pull requests and main. GitLeaks and high or critical dependency findings fail their jobs. Kubernetes configuration findings are currently reported without failing the job because existing manifests have unverified runtime requirements and baseline flags. The workflow uses read-only repository permissions and does not run project deployment commands.

Dependabot alerts and automated security fixes are enabled in repository settings. The `dependabot.yml` file updates GitHub Actions references weekly. This repository has no Python dependency manifest or lockfile, so a clean Trivy dependency result does not establish that the producer or container images have no vulnerable packages.

## Deployment validation

The audit report records runtime-dependent checks for the Neo4j credential, Kafka and ZooKeeper client access, and Kafka Connect management access. Validate these in a separate, network-isolated staging environment with dummy data and the active image and chart versions. Do not test them against a live or shared deployment. A published credential must be rotated wherever it was used; removing it from current files does not erase Git history.
