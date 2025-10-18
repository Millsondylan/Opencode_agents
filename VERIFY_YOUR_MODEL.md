# How to Verify Your Actual Model Usage

This guide ensures your agents use EXACTLY the model you configured - no surprises!

---

## Quick Validation

Run this command anytime to verify your configuration:

```bash
python3 ~/.config/opencode/validate_model_usage.py
```

**Expected output:**
```
✅ PERFECT CONFIGURATION!
   All 95 agents use: your-model-here
   No fallback models configured
   No model mismatches found

✅ YOUR USAGE WILL BE:
   - Every agent call uses: your-model-here
   - No alternative models
   - 100% predictable usage
```

---

## Step-by-Step: Setting Your Model

### Example: Using Gemini 2.5 Pro (Cost Savings)

**Step 1: Edit configuration**
```bash
cd ~/.config/opencode
# Edit opencode.json, change line:
"coordinator": {
  "model": "google/gemini-2.5-pro"
}
```

**Step 2: Run sync script**
```bash
python3 sync_agent_models.py
```

Expected output:
```
📋 Coordinator model: google/gemini-2.5-pro
🤖 Model type: Non-Claude (e.g., Gemini)
🧠 Extended thinking: Disabled

🔒 STRICT MODE: Removing ALL fallback models
   Agents will ONLY use coordinator's model

✅ Updated 95 agents to use: google/gemini-2.5-pro
✅ Removed 0 fallback models (strict enforcement)
✅ Disabled extended thinking for 95 agents

📊 Summary:
   Total agents: 95
   All using: google/gemini-2.5-pro
   Extended thinking: Disabled
   Fallback models: None (strict enforcement)

🔒 STRICT ENFORCEMENT ENABLED:
   Every agent call will use: google/gemini-2.5-pro
   No alternative models configured
   100% predictable usage
```

**Step 3: Validate**
```bash
python3 validate_model_usage.py
```

Should show:
```
✅ YOUR USAGE WILL BE:
   - Every agent call uses: google/gemini-2.5-pro
```

---

## What Each Model Means for Usage

### If you set: `google/gemini-2.5-pro`

**Your actual usage:**
- ✅ Every agent uses: Gemini 2.5 Pro
- ✅ Input cost: $1.25 per 1M tokens
- ✅ Output cost: $5.00 per 1M tokens
- ✅ Extended thinking: Disabled (not supported)
- ✅ Cost savings: ~65% vs Claude

### If you set: `anthropic/claude-sonnet-4-5`

**Your actual usage:**
- ✅ Every agent uses: Claude Sonnet 4-5
- ✅ Input cost: $3 per 1M tokens
- ✅ Output cost: $15 per 1M tokens
- ✅ Extended thinking: Enabled
- ✅ Balanced quality/cost

### If you set: `anthropic/claude-opus-4-1`

**Your actual usage:**
- ✅ Every agent uses: Claude Opus 4-1
- ✅ Input cost: $15 per 1M tokens
- ✅ Output cost: $75 per 1M tokens
- ✅ Extended thinking: Enabled
- ✅ Maximum reasoning capability

---

## How to Check What You're Currently Using

**Quick check:**
```bash
cd ~/.config/opencode
grep '"model"' opencode.json | head -3
```

Output will show:
```json
    "coordinator": {
      "model": "google/gemini-2.5-pro",
```

This is what ALL your agents will use!

---

## Troubleshooting: My Usage Doesn't Match!

### Problem: I set Gemini but usage shows Claude

**Solution:**
```bash
cd ~/.config/opencode

# 1. Verify coordinator model
grep -A 2 '"coordinator"' opencode.json | grep model

# 2. Run sync to fix
python3 sync_agent_models.py

# 3. Validate
python3 validate_model_usage.py
```

### Problem: Usage is higher/lower than expected

**Check your actual model:**
```bash
python3 validate_model_usage.py
```

Look for this line:
```
✅ YOUR USAGE WILL BE:
   - Every agent call uses: <YOUR_ACTUAL_MODEL>
```

This is EXACTLY what will be billed!

---

## Monthly Cost Calculator

Based on moderate usage (500K tokens input, 200K tokens output per month):

| Model | Input Cost | Output Cost | Total/Month |
|-------|-----------|-------------|-------------|
| Gemini 2.5 Pro | $0.63 | $1.00 | **$1.63** |
| Claude Sonnet 4-5 | $1.50 | $3.00 | **$4.50** |
| Claude Opus 4-1 | $7.50 | $15.00 | **$22.50** |

**Your actual cost depends on:**
1. ✅ Which model you configured (check with `validate_model_usage.py`)
2. ✅ How many tokens you use
3. ✅ That's it - no surprises!

---

## Best Practice: Validate Before Big Tasks

Before starting a large task:

```bash
# Check your model
python3 ~/.config/opencode/validate_model_usage.py

# If you want to use Gemini for cost savings:
# 1. Edit opencode.json: set coordinator.model = "google/gemini-2.5-pro"
# 2. Run: python3 sync_agent_models.py
# 3. Verify: python3 validate_model_usage.py

# Now run your task - all agents will use Gemini!
```

---

## Automated Validation

Add to your shell profile (`.bashrc` or `.zshrc`):

```bash
alias verify-opencode='python3 ~/.config/opencode/validate_model_usage.py'
```

Then just run:
```bash
verify-opencode
```

Anytime you want to check your configuration!

---

## Summary

✅ **Your agents use EXACTLY what you configure**
✅ **No fallback models (removed for strict enforcement)**
✅ **No surprises in usage or cost**
✅ **100% predictable billing**

**To verify right now:**
```bash
python3 ~/.config/opencode/validate_model_usage.py
```

**To change models:**
```bash
# 1. Edit opencode.json
# 2. Run: python3 sync_agent_models.py
# 3. Verify: python3 validate_model_usage.py
```

**Your usage will match your configuration - guaranteed!**
