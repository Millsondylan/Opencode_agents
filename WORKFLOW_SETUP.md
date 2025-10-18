# Complete Setup Guide: 24/7 GitHub Workflows with Gemini 2.5 Pro

## Quick Start

Get your repositories running with 24/7 AI-powered enhancement, debugging, and maintenance in 3 steps:

### Step 1: Get Google AI API Key

1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Sign in with your Google account
3. Click "Create API Key"
4. Copy the API key (you'll need it in Step 3)

### Step 2: Deploy Workflows

Choose one method:

#### Method A: Deploy to All Repositories in an Organization

```bash
# Clone this repository
git clone https://github.com/Millsondylan/Opencode_agents.git
cd Opencode_agents

# Deploy to all repos in your organization
./deploy-workflows.sh --org your-organization-name
```

#### Method B: Deploy to Specific Repositories

```bash
# Create a list of repositories
cat > repos.txt << EOF
username/repo1
username/repo2
username/repo3
EOF

# Deploy to listed repositories
./deploy-workflows.sh --repos repos.txt
```

#### Method C: Deploy to a Single Repository

```bash
./deploy-workflows.sh --single username/repository-name
```

#### Method D: Manual Deployment

```bash
# Navigate to your repository
cd /path/to/your/repository

# Create workflows directory
mkdir -p .github/workflows

# Copy workflow files
cp /path/to/Opencode_agents/.github/workflows/*.yml .github/workflows/
cp /path/to/Opencode_agents/.github/workflows/README.md .github/workflows/

# Commit and push
git add .github/workflows/
git commit -m "Add 24/7 automation workflows with Gemini 2.5 Pro"
git push
```

### Step 3: Add API Key Secrets

**For each repository**, add the Google AI API key as a secret:

#### Via GitHub Web UI:

1. Go to your repository on GitHub
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add secret:
   - Name: `GOOGLE_GENERATIVE_AI_API_KEY`
   - Value: `your_api_key_from_step_1`
5. Click **Add secret**
6. Repeat for second secret:
   - Name: `GEMINI_API_KEY`
   - Value: `same_api_key_as_above`

#### Via GitHub CLI:

```bash
# Set the API key
export API_KEY="your_google_ai_api_key"

# Add to single repository
gh secret set GOOGLE_GENERATIVE_AI_API_KEY --body "$API_KEY" --repo username/repo-name
gh secret set GEMINI_API_KEY --body "$API_KEY" --repo username/repo-name

# Add to all repositories in an organization
for repo in $(gh repo list your-org --limit 1000 --json nameWithOwner -q '.[].nameWithOwner'); do
  echo "Adding secrets to $repo..."
  gh secret set GOOGLE_GENERATIVE_AI_API_KEY --body "$API_KEY" --repo "$repo"
  gh secret set GEMINI_API_KEY --body "$API_KEY" --repo "$repo"
done
```

---

## What You Get

Once deployed, each repository will have:

### 1. Code Enhancement (Every 6 Hours)
- Automated code quality analysis
- Performance optimization suggestions
- Security hardening recommendations
- Refactoring opportunities
- Best practices enforcement

### 2. Automated Debugging (Every 8 Hours)
- Static code analysis (ESLint, Pylint, etc.)
- Error pattern detection
- Security vulnerability scanning
- Automatic issue responses
- Bug prioritization with fixes

### 3. 24/7 Maintenance (Every 6 Hours)
- Repository health monitoring
- Dependency updates
- Dead code detection
- Test coverage analysis
- Security scanning

---

## Verification

### Check Workflows Are Installed

```bash
# Via GitHub CLI
gh workflow list --repo username/repo-name

# Expected output:
# 24/7 Code Enhancement          active  12345
# 24/7 Automated Debugging        active  12346
# 24/7 Continuous Maintenance     active  12347
```

### Trigger a Test Run

```bash
# Trigger code enhancement manually
gh workflow run "24/7 Code Enhancement" --repo username/repo-name

# Watch the run
gh run watch --repo username/repo-name
```

### View Results

1. Go to your repository on GitHub
2. Click **Actions** tab
3. Select a workflow run
4. Click on the run to see details
5. Download artifacts to view reports

---

## Configuration

### Adjust Run Frequency

Edit the `schedule` section in workflow files:

```yaml
# In .github/workflows/code-enhancement.yml
schedule:
  - cron: '0 */12 * * *'  # Change from every 6 hours to every 12 hours
```

**Cron Schedule Examples**:
- Every 6 hours: `0 */6 * * *`
- Every 12 hours: `0 */12 * * *`
- Once daily at midnight: `0 0 * * *`
- Once weekly: `0 0 * * 0`

Use [crontab.guru](https://crontab.guru/) to create custom schedules.

### Enable/Disable Workflows

#### Disable a workflow:
```bash
gh workflow disable "24/7 Code Enhancement" --repo username/repo-name
```

#### Enable a workflow:
```bash
gh workflow enable "24/7 Code Enhancement" --repo username/repo-name
```

#### Disable for inactive repositories:
```bash
# List inactive repos (no commits in 90 days)
gh repo list your-org --limit 1000 --json nameWithOwner,pushedAt \
  --jq '.[] | select(.pushedAt < (now - 90*24*60*60 | strftime("%Y-%m-%dT%H:%M:%SZ"))) | .nameWithOwner'

# Disable workflows for each
for repo in $(gh repo list ...); do
  gh workflow disable "24/7 Code Enhancement" --repo "$repo"
  gh workflow disable "24/7 Automated Debugging" --repo "$repo"
  gh workflow disable "24/7 Continuous Maintenance" --repo "$repo"
done
```

### Customize Analysis Focus

Edit prompts in workflow files to focus on specific areas:

```yaml
# In automated-debugging.yml
cat > debug-prompt.txt << 'EOF'
Focus ONLY on:
1. Security vulnerabilities (SQL injection, XSS, etc.)
2. Performance bottlenecks

Ignore:
- Code style issues
- Minor refactoring opportunities
EOF
```

---

## Cost Management

### Estimated Costs

**Gemini 2.5 Pro Pricing**:
- Input: $1.25 per 1M tokens
- Output: $5.00 per 1M tokens

**Per Repository**:
| Workflow | Runs/Day | Daily Cost | Monthly Cost |
|----------|----------|------------|--------------|
| Code Enhancement | 4 | $0.30 | $9.00 |
| Automated Debugging | 3 | $0.20 | $6.00 |
| 24/7 Maintenance | 4 | $0.15 | $4.50 |
| **Total** | **11** | **$0.65** | **$19.50** |

**Multi-Repository**:
- 10 repositories: ~$195/month
- 50 repositories: ~$975/month
- 100 repositories: ~$1,950/month

### Reduce Costs

1. **Adjust frequency** (biggest impact):
   ```yaml
   # From every 6 hours (4x/day) to every 12 hours (2x/day)
   schedule:
     - cron: '0 */12 * * *'
   ```
   **Savings**: 50% reduction

2. **Switch to manual-only** for low-priority repos:
   ```yaml
   # Remove schedule, keep only workflow_dispatch
   on:
     workflow_dispatch:
   ```
   **Savings**: ~100% (only runs when triggered)

3. **Disable for inactive repositories**:
   ```bash
   gh workflow disable "24/7 Code Enhancement" --repo username/old-repo
   ```

4. **Use conditional triggers**:
   ```yaml
   # Only run on push to main branch
   on:
     push:
       branches: [main]
   ```

5. **Combine workflows** (run all in one job):
   - Reduces overhead
   - Shares context
   - **Savings**: 10-20%

---

## Troubleshooting

### Problem: Workflows Not Running

**Symptoms**: No workflow runs in Actions tab

**Solutions**:
1. Check workflows are enabled:
   ```bash
   gh workflow list --repo username/repo-name
   ```
   If status is "disabled", enable it:
   ```bash
   gh workflow enable "workflow-name" --repo username/repo-name
   ```

2. Verify cron syntax:
   - Test at [crontab.guru](https://crontab.guru/)
   - GitHub uses UTC timezone

3. Check repository permissions:
   - Go to Settings → Actions → General
   - Ensure "Allow all actions and reusable workflows" is selected

### Problem: Authentication Errors

**Error**: `Error: Authentication failed` or `Invalid API key`

**Solutions**:
1. Verify secrets are set:
   ```bash
   gh secret list --repo username/repo-name
   ```
   Expected: `GOOGLE_GENERATIVE_AI_API_KEY`, `GEMINI_API_KEY`

2. Test API key validity:
   ```bash
   curl -H "Content-Type: application/json" \
        -H "x-goog-api-key: YOUR_API_KEY" \
        https://generativelanguage.googleapis.com/v1/models
   ```

3. Regenerate API key:
   - Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Create new API key
   - Update secrets in all repositories

### Problem: High Costs

**Symptoms**: Unexpectedly high Google AI billing

**Solutions**:
1. Check run frequency:
   ```bash
   gh run list --workflow="24/7 Code Enhancement" --limit 100 --repo username/repo
   ```

2. Review token usage in workflow logs

3. Reduce frequency (see Cost Management above)

4. Disable for low-priority repos:
   ```bash
   # List all repos with workflows
   gh repo list --limit 1000 --json nameWithOwner -q '.[].nameWithOwner' | \
   while read repo; do
     echo "Disabling workflows for $repo"
     gh workflow disable "24/7 Code Enhancement" --repo "$repo" 2>/dev/null || true
   done
   ```

### Problem: No Issues Created

**Symptoms**: Workflows run but no issues appear

**Solutions**:
1. Check workflow has permission to create issues:
   ```yaml
   permissions:
     issues: write
   ```

2. Verify conditions are met:
   - Code Enhancement: Runs on schedule/manual
   - Automated Debugging: Creates issues when problems found
   - Maintenance: Creates issues when health score < 80

3. Check rate limiting:
   - GitHub: 60 requests/hour for authenticated API
   - Wait and retry

4. Review workflow logs for errors:
   ```bash
   gh run view --log --repo username/repo-name
   ```

### Problem: Workflow Fails

**Symptoms**: Red X in Actions tab

**Solutions**:
1. View error logs:
   ```bash
   gh run view RUN_ID --log --repo username/repo-name
   ```

2. Common issues:
   - **Missing dependencies**: Add install steps
   - **File not found**: Check paths are correct
   - **Permission denied**: Update repository permissions
   - **Timeout**: Increase timeout in workflow YAML

3. Re-run failed workflow:
   ```bash
   gh run rerun RUN_ID --repo username/repo-name
   ```

---

## Advanced Usage

### Custom Analysis Tools

Add language-specific tools:

#### Python
```yaml
- name: Setup Python
  uses: actions/setup-python@v4
  with:
    python-version: '3.11'

- name: Install Analysis Tools
  run: |
    pip install pylint flake8 bandit mypy black

- name: Run Analysis
  run: |
    pylint **/*.py > pylint-report.txt
    flake8 . > flake8-report.txt
    bandit -r . -f json -o bandit-report.json
    mypy . > mypy-report.txt
```

#### Java
```yaml
- name: Setup Java
  uses: actions/setup-java@v4
  with:
    java-version: '17'

- name: Run SpotBugs
  run: ./gradlew spotbugsMain

- name: Run Checkstyle
  run: ./gradlew checkstyleMain
```

#### Go
```yaml
- name: Setup Go
  uses: actions/setup-go@v4
  with:
    go-version: '1.21'

- name: Run Static Analysis
  run: |
    go vet ./...
    golint ./...
    staticcheck ./...
```

### Slack/Discord Notifications

Add notifications for workflow results:

#### Slack
```yaml
- name: Send Slack Notification
  if: always()
  uses: slackapi/slack-github-action@v1
  with:
    payload: |
      {
        "text": "Workflow ${{ job.status }}: ${{ github.workflow }}",
        "blocks": [
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": "Workflow *${{ github.workflow }}* ${{ job.status }} for repository *${{ github.repository }}*"
            }
          }
        ]
      }
  env:
    SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}
```

#### Discord
```yaml
- name: Send Discord Notification
  if: always()
  uses: sarisia/actions-status-discord@v1
  with:
    webhook: ${{ secrets.DISCORD_WEBHOOK }}
    title: "Workflow: ${{ github.workflow }}"
    description: "Status: ${{ job.status }}"
```

### Custom Reports

Generate custom reports with specific metrics:

```yaml
- name: Generate Custom Report
  run: |
    cat > CUSTOM_REPORT.md << 'EOF'
    # Custom Analysis Report

    ## Code Metrics
    $(cloc . --json)

    ## Test Coverage
    $(npm test -- --coverage --json)

    ## Dependencies
    $(npm outdated --json)

    ## Security
    $(npm audit --json)

    ---
    Generated: $(date)
    EOF
```

---

## Best Practices

### 1. Start Small
- Deploy to 1-2 test repos first
- Monitor costs and performance
- Adjust settings based on results
- Gradually roll out to more repositories

### 2. Regular Review
- Check reports weekly
- Prioritize critical issues
- Track trends over time
- Adjust focus areas as needed

### 3. Customize for Your Stack
- Add language-specific tools
- Configure for your frameworks
- Adjust prompts for your standards
- Integrate with your CI/CD

### 4. Security First
- **Never** commit API keys
- Rotate keys quarterly
- Use repository-level secrets
- Review automated changes before merging

### 5. Cost Optimization
- Monitor usage weekly
- Disable for inactive repos
- Adjust frequency based on priority
- Use manual triggers for low-priority repos

---

## Maintenance

### Update Workflows

When new versions are released:

```bash
# Pull latest changes
cd Opencode_agents
git pull

# Redeploy to all repos
./deploy-workflows.sh --org your-organization-name
```

### Monitor Health

Check workflow health across all repositories:

```bash
#!/bin/bash

# Check status of all workflows
for repo in $(gh repo list your-org --limit 1000 --json nameWithOwner -q '.[].nameWithOwner'); do
  echo "=== $repo ==="
  gh workflow list --repo "$repo"
  echo ""
done
```

### Bulk Operations

Perform operations across all repositories:

```bash
# Disable all workflows
for repo in $(gh repo list your-org --limit 1000 --json nameWithOwner -q '.[].nameWithOwner'); do
  gh workflow disable "24/7 Code Enhancement" --repo "$repo" 2>/dev/null
  gh workflow disable "24/7 Automated Debugging" --repo "$repo" 2>/dev/null
  gh workflow disable "24/7 Continuous Maintenance" --repo "$repo" 2>/dev/null
done

# Enable all workflows
for repo in $(gh repo list your-org --limit 1000 --json nameWithOwner -q '.[].nameWithOwner'); do
  gh workflow enable "24/7 Code Enhancement" --repo "$repo" 2>/dev/null
  gh workflow enable "24/7 Automated Debugging" --repo "$repo" 2>/dev/null
  gh workflow enable "24/7 Continuous Maintenance" --repo "$repo" 2>/dev/null
done
```

---

## Support & Resources

### Documentation
- [GitHub Actions](https://docs.github.com/en/actions)
- [Google AI](https://ai.google.dev/docs)
- [OpenCode](https://docs.opencode.ai/)
- [Gemini API](https://ai.google.dev/docs/gemini_api_overview)

### Community
- [GitHub Discussions](https://github.com/Millsondylan/Opencode_agents/discussions)
- [Issues](https://github.com/Millsondylan/Opencode_agents/issues)

### Getting Help
1. Check workflow logs first
2. Review this guide
3. Search existing issues
4. Open a new issue with details

---

## FAQ

**Q: Can I use a different AI model?**
A: Yes, but you'll need to modify the workflows to use a different API. The workflows are configured for Gemini 2.5 Pro specifically.

**Q: How do I stop workflows temporarily?**
A: Disable them:
```bash
gh workflow disable "workflow-name" --repo username/repo-name
```

**Q: Can I use this with private repositories?**
A: Yes, the workflows work with both public and private repositories.

**Q: What if I don't want daily runs?**
A: Adjust the `schedule` in each workflow file or use `workflow_dispatch` (manual only).

**Q: How do I see the AI's analysis?**
A: Download the workflow artifacts from the Actions tab. They contain detailed reports.

**Q: Can I customize the prompts?**
A: Yes, edit the prompt sections in each workflow file.

**Q: Will this work with monorepos?**
A: Yes, but you may need to adjust file paths and analysis scope.

**Q: How do I uninstall?**
A: Delete the `.github/workflows/*.yml` files and commit:
```bash
rm .github/workflows/code-enhancement.yml
rm .github/workflows/automated-debugging.yml
rm .github/workflows/24-7-maintenance.yml
git commit -am "Remove automation workflows"
git push
```

---

**Ready to enable 24/7 AI-powered development across all your repositories.**
