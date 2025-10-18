# 24/7 GitHub Workflows with Gemini 2.5 Pro

## Overview

This directory contains three comprehensive GitHub Actions workflows that provide 24/7 automated code enhancement, debugging, and maintenance using **Gemini 2.5 Pro**.

## Workflows

### 1. Code Enhancement (`code-enhancement.yml`)

**Runs**: Every 6 hours + on push/PR
**Purpose**: Continuously improve code quality

**Features**:
- Code quality analysis
- Performance optimization suggestions
- Security hardening recommendations
- Best practices enforcement
- Refactoring opportunities
- Dependency security scanning
- Documentation enhancement

**Triggers**:
- `push` to main/master/develop
- `pull_request` opened/updated
- `schedule`: Every 6 hours (4x daily)
- `workflow_dispatch`: Manual with focus options

**Manual Options**:
- `enhancement_focus`: all | performance | security | quality | refactoring
- Default: `all`

### 2. Automated Debugging (`automated-debugging.yml`)

**Runs**: Every 8 hours + on issues/push
**Purpose**: Detect and help fix bugs automatically

**Features**:
- Static code analysis (ESLint, Pylint, Flake8, Bandit)
- Error pattern detection
- Security vulnerability scanning
- Performance profiling
- Automatic issue responses
- Bug prioritization
- Fix suggestions with code examples

**Triggers**:
- `issues`: opened/labeled
- `discussion`: created/labeled
- `schedule`: Every 8 hours (3x daily)
- `push` to main/master/develop
- `workflow_dispatch`: Manual with debug options

**Manual Options**:
- `debug_focus`: all | errors | performance | memory | security
- `severity`: low | medium | high | critical
- Defaults: `all`, `medium`

### 3. 24/7 Maintenance (`24-7-maintenance.yml`)

**Runs**: Every 6 hours
**Purpose**: Continuous repository health monitoring

**Features**:
- Repository health scoring
- Dependency updates monitoring
- Dead code detection
- Code duplication analysis
- Complexity analysis
- Test coverage monitoring
- Security scanning
- Maintenance summary reports

**Triggers**:
- `schedule`: Every 6 hours (4x daily)
- `push` to main/master
- `workflow_dispatch`: Manual with maintenance options

**Manual Options**:
- `maintenance_type`: full | quick | security | dependencies
- `auto_fix`: true | false
- Defaults: `full`, `false`

## Setup Instructions

### Prerequisites

1. **GitHub Repository** with code to analyze
2. **Google Generative AI API Key** for Gemini 2.5 Pro
3. **GitHub Secrets** configured (see below)

### Required Secrets

Add these secrets to your repository (Settings → Secrets and variables → Actions):

```
GOOGLE_GENERATIVE_AI_API_KEY=your_google_ai_api_key_here
GEMINI_API_KEY=your_gemini_api_key_here  # Can be same as above
```

**How to get API keys**:
1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Sign in with your Google account
3. Create a new API key
4. Copy and add to GitHub secrets

### Installation

#### Option 1: Use This Repository's Workflows

1. **Copy workflow files** to your repository:
   ```bash
   mkdir -p .github/workflows
   cp path/to/this/repo/.github/workflows/*.yml .github/workflows/
   ```

2. **Add secrets** to your repository:
   - Go to Settings → Secrets and variables → Actions
   - Add `GOOGLE_GENERATIVE_AI_API_KEY`
   - Add `GEMINI_API_KEY`

3. **Commit and push**:
   ```bash
   git add .github/workflows/
   git commit -m "Add 24/7 automation workflows with Gemini 2.5 Pro"
   git push
   ```

4. **Verify workflows**:
   - Go to Actions tab
   - You should see three new workflows listed
   - Trigger manually to test: Actions → Select workflow → Run workflow

#### Option 2: Deploy to All Your Repositories

Use the deployment script (see below) to deploy to multiple repositories at once.

## Workflow Schedule

| Workflow | Frequency | Runs Per Day | Daily Runtime |
|----------|-----------|--------------|---------------|
| Code Enhancement | Every 6 hours | 4 | 00:00, 06:00, 12:00, 18:00 UTC |
| Automated Debugging | Every 8 hours | 3 | 00:00, 08:00, 16:00 UTC |
| 24/7 Maintenance | Every 6 hours | 4 | 00:00, 06:00, 12:00, 18:00 UTC |

**Total**: Up to 11 automated runs per day across all workflows.

## Manual Triggers

All workflows support manual triggering with custom options:

### Code Enhancement
```bash
# Via GitHub UI: Actions → Code Enhancement → Run workflow
# Options:
#   - enhancement_focus: all/performance/security/quality/refactoring
```

### Automated Debugging
```bash
# Via GitHub UI: Actions → Automated Debugging → Run workflow
# Options:
#   - debug_focus: all/errors/performance/memory/security
#   - severity: low/medium/high/critical
```

### 24/7 Maintenance
```bash
# Via GitHub UI: Actions → 24/7 Maintenance → Run workflow
# Options:
#   - maintenance_type: full/quick/security/dependencies
#   - auto_fix: true/false
```

## Outputs & Artifacts

Each workflow generates detailed reports and stores them as artifacts:

### Code Enhancement
- `ENHANCEMENT_REPORT.md` - Detailed enhancement suggestions
- `analysis-report.md` - Code analysis statistics
- `enhancement-results.json` - Machine-readable results
- `DEPENDENCY_REPORT.md` - Dependency security report

**Retention**: 30 days

### Automated Debugging
- `ERROR_REPORT.md` - Comprehensive error detection report
- `debug-results.json` - Structured debugging data
- `potential-secrets.txt` - Hardcoded secrets scan
- `static-analysis/` - ESLint, Pylint, Flake8, Bandit results
- `PERFORMANCE_REPORT.md` - Performance profiling

**Retention**: 30 days

### 24/7 Maintenance
- `HEALTH_REPORT.md` - Repository health score and issues
- `DEPENDENCY_MAINTENANCE.md` - Dependency update recommendations
- `CODE_MAINTENANCE.md` - Code cleanup suggestions
- `TEST_COVERAGE_REPORT.md` - Test coverage analysis
- `SECURITY_SCAN.md` - Security scan results
- Various JSON reports

**Retention**: 30-90 days (health reports kept longer)

## GitHub Issues Integration

Workflows automatically create GitHub issues for findings:

### Enhancement Issues
- **Label**: `enhancement`, `automated`, `code-quality`
- **Created**: On scheduled runs
- **Contains**: Prioritized improvement suggestions

### Debug Issues
- **Label**: `bug`, `automated`, `debugging`
- **Created**: On scheduled runs or when issues detected
- **Contains**: Error reports with severity levels

### Maintenance Issues
- **Label**: `maintenance`, `automated`, `24-7`
- **Created**: When health score < 80 or on schedule
- **Contains**: Maintenance summary and action items

### Auto-Response to User Issues
When users create issues, the debugging workflow automatically:
1. Analyzes the issue with Gemini 2.5 Pro
2. Provides initial diagnosis
3. Suggests debugging steps
4. Asks clarifying questions

## Cost Optimization

### Gemini 2.5 Pro Pricing
- **Input**: $1.25 per 1M tokens
- **Output**: $5.00 per 1M tokens

### Estimated Costs (Per Repository)

| Workflow | Tokens/Run | Runs/Day | Daily Cost | Monthly Cost |
|----------|-----------|----------|------------|--------------|
| Code Enhancement | ~50K | 4 | ~$0.30 | ~$9 |
| Automated Debugging | ~40K | 3 | ~$0.20 | ~$6 |
| 24/7 Maintenance | ~30K | 4 | ~$0.15 | ~$4.50 |
| **Total** | - | 11 | **~$0.65** | **~$19.50** |

**For 10 repositories**: ~$195/month
**For 50 repositories**: ~$975/month

### Cost Reduction Tips
1. Adjust schedules (e.g., every 12 hours instead of 6)
2. Use `workflow_dispatch` (manual only)
3. Disable workflows for inactive repositories
4. Use conditional triggers (only on push to main)

## Customization

### Adjust Schedule

Edit cron expressions in workflow files:

```yaml
schedule:
  - cron: '0 */12 * * *'  # Change from 6 to 12 hours
```

**Cron Helper**: [crontab.guru](https://crontab.guru/)

### Change Focus Areas

Modify the analysis prompts in each workflow:

```yaml
# In automated-debugging.yml
cat > debug-prompt.txt << 'EOF'
Focus only on security vulnerabilities and performance issues.
Ignore code style and formatting.
EOF
```

### Add Custom Checks

Add steps to workflows:

```yaml
- name: Custom Security Check
  run: |
    # Your custom security scanning tool
    your-security-tool --scan .
```

### Filter by File Types

Add file filters to analysis:

```bash
# Only analyze JavaScript files
find . -name "*.js" -not -path "*/node_modules/*"
```

## Troubleshooting

### Workflow Not Running

**Check**:
1. Workflows enabled in repository settings
2. Cron syntax is correct
3. Branch protection rules aren't blocking

**Fix**:
- Go to Actions tab → Enable workflows
- Verify cron at [crontab.guru](https://crontab.guru/)
- Check Settings → Branches

### API Key Errors

**Error**: `Authentication failed` or `Invalid API key`

**Fix**:
1. Verify secrets are set correctly
2. Check API key is valid at [Google AI Studio](https://makersuite.google.com/)
3. Ensure key has Gemini 2.5 Pro access

### No Issues Created

**Check**:
1. Workflow has `issues: write` permission
2. Conditions for issue creation are met
3. No rate limiting

**Fix**:
- Verify workflow permissions in YAML
- Check workflow logs for conditions
- Wait if rate limited (60 requests/hour for authenticated)

### High Costs

**Reduce costs**:
1. Decrease run frequency
2. Switch to manual triggers only
3. Limit to critical repositories
4. Use smaller context windows

## Multi-Repository Deployment

### Deployment Script

Create `deploy-workflows.sh`:

```bash
#!/bin/bash

# Deploy 24/7 workflows to all repositories

REPOS=(
  "your-org/repo1"
  "your-org/repo2"
  "your-org/repo3"
)

WORKFLOW_DIR="$(dirname "$0")/.github/workflows"

for repo in "${REPOS[@]}"; do
  echo "Deploying to $repo..."

  # Clone repository
  git clone "git@github.com:$repo.git" "temp-$repo" 2>/dev/null || (cd "temp-$repo" && git pull)

  # Copy workflows
  mkdir -p "temp-$repo/.github/workflows"
  cp $WORKFLOW_DIR/*.yml "temp-$repo/.github/workflows/"

  # Commit and push
  cd "temp-$repo"
  git add .github/workflows/
  git commit -m "Add 24/7 automation workflows with Gemini 2.5 Pro" || true
  git push
  cd ..

  # Cleanup
  rm -rf "temp-$repo"

  echo "✅ Deployed to $repo"
done

echo "🎉 Deployment complete!"
```

**Usage**:
```bash
chmod +x deploy-workflows.sh
./deploy-workflows.sh
```

### GitHub CLI Method

Using `gh` CLI to deploy to multiple repos:

```bash
#!/bin/bash

REPOS=($(gh repo list your-org --limit 100 --json nameWithOwner -q '.[].nameWithOwner'))

for repo in "${REPOS[@]}"; do
  echo "Deploying to $repo..."
  gh repo clone "$repo" "temp-repo"
  mkdir -p "temp-repo/.github/workflows"
  cp .github/workflows/*.yml "temp-repo/.github/workflows/"
  cd "temp-repo"
  git add .github/workflows/
  git commit -m "Add 24/7 automation workflows" || true
  git push
  cd ..
  rm -rf "temp-repo"
done
```

## Best Practices

### 1. Start Small
- Deploy to 1-2 test repositories first
- Monitor costs and adjust
- Gradually roll out to more repos

### 2. Review Reports Regularly
- Check workflow artifacts weekly
- Prioritize critical issues
- Disable workflows for inactive repos

### 3. Customize for Your Stack
- Adjust analysis tools (ESLint, Pylint, etc.)
- Add language-specific checks
- Configure for your testing framework

### 4. Manage Notifications
- Configure GitHub notifications
- Use issue labels for filtering
- Set up Slack/Discord webhooks

### 5. Security
- **Never** commit API keys to code
- Rotate API keys quarterly
- Use repository-level secrets (not organization-level for sensitive projects)
- Review automated PR changes before merging

## Support

### Common Issues
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Google AI Documentation](https://ai.google.dev/docs)
- [OpenCode Documentation](https://docs.opencode.ai/)

### Getting Help
1. Check workflow logs in Actions tab
2. Review artifact reports
3. Open an issue in this repository
4. Check GitHub Actions community

## License

These workflows are provided as-is for use with OpenCode and Gemini 2.5 Pro.

## Credits

- **OpenCode**: Multi-agent AI framework
- **Gemini 2.5 Pro**: Google's advanced AI model
- **GitHub Actions**: CI/CD platform

---

**Ready to automate your development workflow 24/7 with AI-powered code enhancement, debugging, and maintenance.**
