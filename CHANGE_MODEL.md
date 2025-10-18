# Changing OpenCode Agent Models

All 96 agents in the OpenCode configuration follow the **coordinator's model**. When you change the coordinator's model, all agents automatically update to match.

---

## Current Configuration

**All agents use**: `anthropic/claude-sonnet-4-5`
- **Extended Thinking**: Enabled (all 96 agents)
- **Model Type**: Claude
- **Status**: ✅ Synchronized

---

## How to Change Models

### Option 1: Use the Sync Script (Recommended)

1. **Edit the coordinator model** in the configuration:

```bash
cd /Users/ai/.config/opencode
```

Edit `opencode.json` and change the coordinator model:

```json
{
  "agent": {
    "coordinator": {
      "mode": "primary",
      "model": "google/gemini-2.5-pro",  // Change this line
      "description": "Strategic manager..."
    }
  }
}
```

2. **Run the sync script**:

```bash
python3 /Users/ai/.config/opencode/sync_agent_models.py
```

This will automatically:
- Update all 95 worker agents to use the new model
- Update the `_base` configuration
- Enable/disable extended thinking based on model capabilities
- Remove Claude-specific features if switching to non-Claude models

### Option 2: Manual Update

If you prefer to manually update the configuration:

1. Edit `opencode.json`
2. Change the `coordinator.model` field
3. Update each agent's `model` field to match
4. Update `_base.model` field
5. Adjust `options.thinking` based on model support

**Not recommended** - use the sync script instead to avoid errors.

---

## Supported Models

### Claude Models (with Extended Thinking)

```json
"anthropic/claude-opus-4-1"
"anthropic/claude-opus-4-0"
"anthropic/claude-sonnet-4-5"
"anthropic/claude-sonnet-4-0"
"anthropic/claude-3-7-sonnet-latest"
"anthropic/claude-3-5-sonnet-20241022"
```

**Features**:
- ✅ Extended thinking capability
- ✅ Deep reasoning
- ✅ Complex problem solving
- ⚠️ Higher cost

### Gemini Models (Cost Optimized)

```json
"google/gemini-2.5-pro"
"google/gemini-2.5-flash"
"google/gemini-2.0-flash-exp"
```

**Features**:
- ✅ Fast execution
- ✅ Lower cost (60-70% cheaper)
- ✅ High quality
- ❌ No extended thinking

### Other Models

```json
"openai/gpt-4-turbo"
"openai/gpt-4o"
"openai/o1-preview"
```

**Note**: Extended thinking availability varies by model.

---

## Examples

### Example 1: Switch to Gemini 2.5 Pro

**Why**: Reduce costs by 60-70% while maintaining quality

```bash
# 1. Edit opencode.json
cd /Users/ai/.config/opencode
```

Change:
```json
"coordinator": {
  "mode": "primary",
  "model": "google/gemini-2.5-pro",
  "description": "Strategic manager..."
}
```

```bash
# 2. Run sync script
python3 sync_agent_models.py
```

**Result**:
- All 96 agents now use Gemini 2.5 Pro
- Extended thinking disabled (not supported)
- Cost reduced by ~65%

### Example 2: Switch to Claude Opus 4

**Why**: Maximum reasoning capability for complex tasks

```bash
# 1. Edit opencode.json
cd /Users/ai/.config/opencode
```

Change:
```json
"coordinator": {
  "mode": "primary",
  "model": "anthropic/claude-opus-4-1",
  "description": "Strategic manager..."
}
```

```bash
# 2. Run sync script
python3 sync_agent_models.py
```

**Result**:
- All 96 agents now use Claude Opus 4.1
- Extended thinking enabled (supported)
- Maximum reasoning capability
- Higher cost (~2x Sonnet)

### Example 3: Mixed Strategy

**Use Case**: Claude for coordinator, Gemini for workers (cost optimization)

This is **not recommended** with the current setup, but if you want different models for different agents, you would need to manually configure each agent.

The recommended approach is to use the **fallback model** feature:

```json
"agent": {
  "coordinator": {
    "model": "anthropic/claude-sonnet-4-5"
  },
  "coder-1": {
    "model": "anthropic/claude-sonnet-4-5",
    "fallback_model": "google/gemini-2.5-flash"  // Used for >10 agents
  }
}
```

This way:
- Small tasks (<10 agents): Use Claude
- Large tasks (>10 agents): Use Gemini fallback
- Automatic cost optimization

---

## Verification

After changing models, verify the configuration:

```bash
cd /Users/ai/.config/opencode

# Check model distribution
python3 << 'EOF'
import json

with open('opencode.json', 'r') as f:
    config = json.load(f)

models = {}
for agent_name, agent_config in config['agent'].items():
    if agent_name == '_base':
        continue
    model = agent_config.get('model', 'None')
    models[model] = models.get(model, 0) + 1

print("Model Distribution:")
for model, count in sorted(models.items(), key=lambda x: x[1], reverse=True):
    print(f"  {model}: {count} agents")

print(f"\nAll agents using same model: {len(models) == 1}")
EOF
```

Expected output:
```
Model Distribution:
  your-new-model: 96 agents

All agents using same model: True
```

---

## Cost Comparison

### Monthly Costs (96 agents, moderate usage)

| Model | Cost/1M tokens | Est. Monthly | Savings |
|-------|---------------|--------------|---------|
| Claude Opus 4 | $15 input/$75 output | ~$450 | Baseline +250% |
| Claude Sonnet 4.5 | $3 input/$15 output | ~$180 | Baseline |
| Gemini 2.5 Pro | $1.25 input/$5 output | ~$60 | -67% |
| Gemini 2.5 Flash | $0.075 input/$0.30 output | ~$3.60 | -98% |

**Note**: Costs are estimates. Actual usage varies by task complexity.

---

## Best Practices

### 1. Choose Based on Task Complexity

| Task Type | Recommended Model | Reason |
|-----------|------------------|---------|
| Complex architecture | Claude Opus 4 | Maximum reasoning |
| General development | Claude Sonnet 4.5 | Balanced quality/cost |
| High volume tasks | Gemini 2.5 Pro | Cost optimized |
| Simple automation | Gemini 2.5 Flash | Minimal cost |

### 2. Use Fallback Models

Keep fallback models for cost optimization:

```json
"model": "anthropic/claude-sonnet-4-5",
"fallback_model": "google/gemini-2.5-flash"
```

This provides:
- Quality for small tasks (Claude)
- Cost optimization for large tasks (Gemini)

### 3. Monitor Usage

Track token usage and costs:

```bash
# OpenCode provides built-in usage tracking
# Check the dashboard after each run
```

### 4. Test Before Production

When changing models:
1. Test with a single agent first
2. Verify output quality
3. Check cost impact
4. Roll out to all agents if satisfied

---

## Rollback

If you need to revert to a previous model:

```bash
# 1. Edit opencode.json back to previous model
cd /Users/ai/.config/opencode

# Change coordinator model back
# For example: "anthropic/claude-sonnet-4-5"

# 2. Run sync script
python3 sync_agent_models.py
```

All agents will immediately revert to the previous model.

---

## Troubleshooting

### Problem: Agents still using old model

**Solution**:
```bash
# Force re-sync
python3 /Users/ai/.config/opencode/sync_agent_models.py
```

### Problem: Extended thinking not working

**Cause**: Model doesn't support thinking

**Solution**: Switch to a Claude model that supports thinking (Opus 4, Sonnet 4)

### Problem: High costs

**Solutions**:
1. Switch to Gemini models
2. Reduce agent count for simple tasks
3. Use fallback models for >10 agents

### Problem: Quality degradation

**Solution**: Switch to higher-tier model (Gemini → Claude Sonnet → Claude Opus)

---

## Automation

To automatically sync models whenever the configuration changes:

```bash
# Add to .opencode/hooks/post-config-update
#!/bin/bash
cd /Users/ai/.config/opencode
python3 sync_agent_models.py
```

Make it executable:
```bash
chmod +x .opencode/hooks/post-config-update
```

---

## Summary

✅ **All agents follow the coordinator's model**

To change models:
1. Edit `coordinator.model` in `opencode.json`
2. Run `python3 sync_agent_models.py`
3. All 96 agents automatically update

**Current**: All agents use `anthropic/claude-sonnet-4-5` with extended thinking

**To optimize costs**: Switch coordinator to `google/gemini-2.5-pro`

**For maximum quality**: Switch coordinator to `anthropic/claude-opus-4-1`

---

*For more information, see the main repository: https://github.com/Millsondylan/Opencode_agents*
