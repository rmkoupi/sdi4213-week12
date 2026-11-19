# Screenshot Evidence Checklist

Use these filenames in an `evidence/` folder in your repository.

1. `01-tools.png` - OpenTofu and Docker versions
2. `02-init.png` - successful `tofu init`
3. `03-validate-plan.png` - successful validation and initial plan
4. `04-first-apply.png` - portal running after first apply
5. `05-state-list.png` - resources shown by `tofu state list`
6. `06-full-stack-plan.png` - plan to add PostgreSQL/Adminer resources
7. `07-full-stack-running.png` - Docker containers + Adminer access
8. `08-database-record.png` - row created in PostgreSQL through Adminer
9. `09-drift-detected.png` - plan detects manually removed DB container
10. `10-reconciled-persistent.png` - recreated DB container and record still present
11. `11-variable-change.png` - plan/apply after host-port variable change
12. `12-destroy.png` - successful destroy and stack removed
13. `13-github-pr.png` - final pull request with IaC Checks passing

Do not capture passwords or other secret values in screenshots.
