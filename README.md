# OpenCode Multi-Agent System Configuration

A comprehensive 96-agent system configuration for [OpenCode](https://opencode.ai/) with intelligent delegation, web search, extended thinking, and complete visibility.

## 🎯 Overview

This repository contains a production-ready multi-agent system for OpenCode featuring:

- **96 Specialized AI Agents** - Covering all development needs
- **Intelligent Coordinator** - Strategic task delegation
- **Web Search Integration** - Proactive documentation lookup
- **Extended Thinking** - Deep analysis for complex problems
- **Complete Visibility** - Token/time/cost tracking
- **Zero Placeholders** - Only complete, working code

## ✨ Features

### 🤖 Agent System
- **96 unique specialized agents** (95 workers + 1 coordinator)
- **8 mandatory quality assurance agents** run on every task
- **Intelligent delegation** - coordinator handles coordination, agents do the work
- **Cost optimization** - 53 agents with Gemini fallback for >10 agent tasks (60-70% savings)

### 🌐 Web Search
- **Proactive documentation lookup** - agents automatically search for latest docs
- **Always current** - prioritizes 2024/2025 information
- **Official sources** - uses authoritative documentation
- **Best practices** - applies current industry standards

### 🧠 Extended Thinking
- **49 Claude agents** with deep reasoning capabilities
- **Complex problem analysis** - thorough architectural evaluation
- **Security considerations** - comprehensive threat modeling
- **Performance optimization** - data-driven decisions

### 📊 Visibility
- **Real-time dashboards** - see exactly what agents are doing
- **Token tracking** - input, output, reasoning, cache per agent
- **Time tracking** - start, complete, duration
- **Cost tracking** - real-time cost calculation

### ⚡ Execution
- **Uninterrupted operations** - no mid-task stops
- **Auto-continue** - resumes incomplete output (up to 5 retries)
- **Long-running task support** - patient with complex operations
- **Completion verification** - ensures all work finishes

## 📦 What's Included

### Configuration Files
- **`opencode.json`** - Complete 96-agent configuration for OpenCode
  - All agent definitions with models, modes, permissions
  - Web search and extended thinking enabled
  - Cost optimization configured
  - No API keys or sensitive information

### Documentation
- **`README.md`** - This file, quick start guide
- **`OPENCODE.md`** - Main system instructions (auto-loaded by OpenCode)
- **`OPENCODE_FINAL_CONFIGURATION.md`** - Complete feature documentation
- **`OPENCODE_SYSTEM_READY.md`** - System readiness report
- **`OPENCODE_BALANCED_SYSTEM.md`** - Detailed usage guide
- **`AGENT_ROSTER_AND_VISIBILITY.md`** - Complete agent catalog
- **`OPENCODE_ARCHITECTURE.md`** - Design rationale and architecture

### 🤖 GitHub Workflows (24/7 Automation)
- **`.github/workflows/code-enhancement.yml`** - Automated code quality improvements (runs every 6 hours)
- **`.github/workflows/automated-debugging.yml`** - Automated error detection and debugging (runs every 8 hours)
- **`.github/workflows/24-7-maintenance.yml`** - Continuous repository maintenance (runs every 6 hours)
- **`.github/workflows/README.md`** - Complete workflow documentation
- **`deploy-workflows.sh`** - Script to deploy workflows to all repositories
- **`WORKFLOW_SETUP.md`** - Complete setup guide for GitHub workflows

All workflows use **Gemini 2.5 Pro** for AI-powered analysis, enhancement, and debugging.

## 🚀 Quick Start

### Prerequisites
- [OpenCode](https://opencode.ai/) installed
- OpenCode CLI access

### Installation

1. **Clone this repository:**
   ```bash
   git clone https://github.com/Millsondylan/Opencode_agents.git
   cd Opencode_agents
   ```

2. **Copy configuration to OpenCode:**
   ```bash
   # Copy agent configuration
   cp opencode.json ~/.config/opencode/opencode.json

   # Copy system instructions to your project
   cp OPENCODE.md /path/to/your/project/OPENCODE.md
   ```

3. **Update your project's `.opencode.json`:**
   ```json
   {
     "contextPaths": [
       "OPENCODE.md"
     ]
   }
   ```

4. **Start OpenCode:**
   ```bash
   cd /path/to/your/project
   opencode
   ```

## 📖 Agent Roster

### Management & Coordination
- **coordinator** - Primary manager that delegates all work
- **verifier** - Final cross-verification

### Planning & Analysis
- **planner-1, planner-2** - Strategic planning
- **analyzer-1, analyzer-2** - Requirements analysis
- **researcher-1, researcher-2, researcher-3** - Research specialists

### Code Generation (8 agents)
- **coder-1** through **coder-8** - Specialized for different coding needs

### Testing & QA (9 agents)
- **tester-1, tester-2, tester-3** - Testing specialists
- **qa-1, qa-2, qa-3** - Quality assurance
- **debugger-1, debugger-2, debugger-3** - Debugging experts

### Plus 70+ More Specialists
Including security, database, API, documentation, architecture, DevOps, performance, data/ML, frontend/UX, and many more specialized agents.

### Mandatory Quality Agents (Always Run)
These 8 agents run on **EVERY task** to ensure quality:

1. **analyzer-1** - Requirements analysis
2. **validator-1** - Input validation
3. **validator-2** - Output validation
4. **formatter-1** - Code formatting
5. **formatter-2** - Documentation formatting
6. **error-handler-1** - Error handling enforcement
7. **linter-1** - Code quality and style
8. **verifier** - Final cross-verification

## 💡 Usage Examples

### Example 1: Simple Question
```
User: "What is REST API?"

Coordinator: Answers directly
Agents Spawned: 0
```

### Example 2: Create Feature
```
User: "Create a user login form"

Coordinator: Spawns 8 agents for implementation

Result: Complete login form with validation, tests, docs
Agents Spawned: 8
```

### Example 3: Complex System
```
User: "Build REST API with authentication"

Coordinator: Spawns 15 specialized agents

Result: Complete API with JWT auth, tests, docs, security hardening
Agents Spawned: 15
```

## 🎯 How It Works

### Coordinator Decision Matrix

| Request Type | Action | Agents |
|-------------|--------|---------|
| Simple question | Answer directly | 0 |
| Explanation | Explain directly | 0 |
| Small feature | Spawn specialists | 5-10 |
| Complex feature | Spawn full team | 10-20 |
| Large project | Spawn extended team | 20-50+ |

### Agent Workflow

```
User Request
    ↓
Coordinator
  🌐 Searches web for docs
  🧠 Analyzes with extended thinking
  📋 Plans implementation
  👥 Selects optimal agents
    ↓
Spawned Agents
  🌐 Search for specialty docs
  🧠 Think through their task
  💻 Implement completely
  ✅ Verify quality
    ↓
Coordinator
  📊 Shows dashboard
  🔧 Integrates outputs
  ✓ Delivers result
```

## 🎨 Customization

### Modify Agent Configuration
Edit `opencode.json` to add agents, adjust models, or change settings.

### Adjust System Behavior
Edit `OPENCODE.md` to modify delegation rules and strategies.

### Cost Optimization
The >10 agents rule automatically switches to Gemini models for 60-70% savings.

## 📊 Performance

| Task Size | Agents | Tokens | Time | Cost |
|-----------|--------|--------|------|------|
| Small | 5 | 10K | 30s | $0.03 |
| Medium | 8 | 25K | 1.5m | $0.08 |
| Large | 15 | 50K | 3m | $0.06* |
| Huge | 30 | 100K | 6m | $0.12* |

*With Gemini cost optimization

## 🔄 GitHub Workflows: 24/7 Automation

This repository includes comprehensive GitHub Actions workflows for 24/7 automated code enhancement, debugging, and maintenance using **Gemini 2.5 Pro**.

### Features

- **Code Enhancement** (every 6 hours) - Automated quality improvements, refactoring, security hardening
- **Automated Debugging** (every 8 hours) - Error detection, vulnerability scanning, automated fixes
- **24/7 Maintenance** (every 6 hours) - Health monitoring, dependency updates, dead code removal

### Quick Setup

1. **Get Google AI API Key**:
   - Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Create an API key for Gemini 2.5 Pro

2. **Deploy to your repositories**:
   ```bash
   # Deploy to all repos in your organization
   ./deploy-workflows.sh --org your-organization-name

   # Or deploy to specific repos
   ./deploy-workflows.sh --repos repos.txt

   # Or deploy to a single repo
   ./deploy-workflows.sh --single username/repo-name
   ```

3. **Add API key as repository secret**:
   ```bash
   gh secret set GOOGLE_GENERATIVE_AI_API_KEY --body "your_api_key"
   gh secret set GEMINI_API_KEY --body "your_api_key"
   ```

### Documentation

- **Complete Setup Guide**: See [WORKFLOW_SETUP.md](WORKFLOW_SETUP.md)
- **Workflow Details**: See [.github/workflows/README.md](.github/workflows/README.md)

### Estimated Costs

| Repositories | Daily Cost | Monthly Cost |
|-------------|-----------|-------------|
| 1 repo | ~$0.65 | ~$19.50 |
| 10 repos | ~$6.50 | ~$195 |
| 50 repos | ~$32.50 | ~$975 |

Costs can be reduced by adjusting run frequency or using manual triggers.

## 🤝 Contributing

Contributions welcome! Feel free to add agents, improve prompts, or share usage patterns.

## 📄 License

Provided as-is for use with OpenCode. Modify and distribute as needed.

## 📞 Support

- Open an issue in this repository
- Check [OpenCode Documentation](https://docs.claude.com/en/docs/claude-code)
- Visit [OpenCode Community](https://opencode.ai/)

---

**Ready to transform your development workflow with 96 AI agents working as one team.**
