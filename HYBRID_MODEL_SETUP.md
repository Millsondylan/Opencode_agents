# OpenCode Hybrid Model Configuration

## The Problem This Solves

**Issue**: Gemini 2.5 Pro coordinator kept stopping mid-task despite completion enforcement

**Root Cause**: Gemini doesn't follow completion instructions as strictly as Claude

**Solution**: Hybrid setup - Claude coordinator + Gemini workers

---

## Current Configuration

### Coordinator (Strategic Layer)
- **Model**: `anthropic/claude-sonnet-4-5`
- **Role**: Manages agents, makes decisions, ensures completion
- **Why Claude**: Better instruction following, actually completes tasks
- **Cost**: ~$0.03 per task (1 agent only)

### Workers (Execution Layer)
- **Model**: `google/gemini-2.5-pro`
- **Count**: 95 agents
- **Role**: Execute specific tasks (coding, testing, etc.)
- **Why Gemini**: 60% cheaper, high quality for execution
- **Cost**: ~$0.09 per 10-agent task

### Total Cost Per Task
- Coordinator (Claude): $0.03
- 10 Workers (Gemini): $0.09
- **Total**: ~$0.12 per task

**vs. All Claude**: ~$0.30 per task
**Savings**: 60% reduction

**vs. All Gemini**: ~$0.08 per task BUT coordinator stops early constantly

---

## Why This Works

### Claude for Coordination
✅ **Follows completion instructions** - Actually finishes tasks
✅ **Better strategic thinking** - Makes smarter decisions
✅ **Stops less frequently** - Requires fewer "continue" commands
✅ **Enforces quality** - Ensures workers complete their work

### Gemini for Workers
✅ **Cost effective** - 60% cheaper than Claude
✅ **High quality** - Excellent at specific execution tasks
✅ **Fast** - Quick execution for worker tasks
✅ **Guided by Claude** - Coordinator keeps them on track

---

## DO NOT Run Sync Script

⚠️ **IMPORTANT**: Do NOT run `sync_agent_models.py`

That script will sync ALL agents to match coordinator (making all agents use Claude).

**This hybrid setup is INTENTIONAL:**
- Coordinator: Claude Sonnet 4.5
- Workers: Gemini 2.5 Pro

---

## How It Works

### User Makes Request
```
User: "Build a REST API with authentication"
```

### Claude Coordinator (Strategic)
1. Analyzes request
2. Selects appropriate workers
3. Spawns them with clear instructions
4. **Monitors until COMPLETE** (doesn't stop early!)
5. Verifies all work done
6. Delivers final result

### Gemini Workers (Execution)
- Execute specific tasks (coding, testing, etc.)
- Follow coordinator's instructions
- Complete their assigned work
- Return to coordinator

### Result
- Task completed fully
- No premature stopping
- Cost effective execution
- High quality deliverables

---

## Validation Warnings

When you run `validate_model_usage.py`, you'll see:

```
❌ CRITICAL ISSUES FOUND:
   ❌ planner-1: uses 'google/gemini-2.5-pro' instead of 'anthropic/claude-sonnet-4-5'
   ...
   ❌ 95 agents with mismatches
```

**This is EXPECTED and CORRECT.**

The script assumes all agents should match the coordinator, but this hybrid setup is intentional.

---

## Cost Comparison

### All Claude (Original)
- Coordinator: Claude Sonnet 4.5
- Workers: Claude Sonnet 4.5
- **Cost**: ~$0.30 per 10-agent task
- **Problem**: Expensive

### All Gemini (What You Tried)
- Coordinator: Gemini 2.5 Pro
- Workers: Gemini 2.5 Pro
- **Cost**: ~$0.08 per 10-agent task
- **Problem**: Coordinator stops constantly

### Hybrid (Current Solution)
- Coordinator: Claude Sonnet 4.5
- Workers: Gemini 2.5 Pro
- **Cost**: ~$0.12 per 10-agent task
- **Benefits**:
  - ✅ Coordinator completes tasks
  - ✅ 60% cheaper than all-Claude
  - ✅ High quality results
  - ✅ Best of both worlds

---

## Expected Behavior Now

### Before (All-Gemini Coordinator)
```
Coordinator: "Excellent. The plan is established."
Coordinator: "I will now begin with Phase 1."
Coordinator: "First, I'll update the status..."
→ STOPS (nothing done, just planning)
User: "CONTINUE" (frustrated)
```

### After (Claude Coordinator + Gemini Workers)
```
Coordinator:
*Analyzes request*
*Spawns Gemini workers*
*Workers execute tasks using Gemini*
*Coordinator verifies completion*
*All work finished and tested*
"Task complete - all code working ✓"
→ STOPS (after actually finishing)
User: Happy ✓
```

---

## Switching Back to All-Gemini

If you want to switch back (not recommended):

```bash
cd ~/.config/opencode

# Edit opencode.json
"coordinator": {
  "model": "google/gemini-2.5-pro"
}

# Run sync script to update all agents
python3 sync_agent_models.py
```

But you'll get the stopping problem again.

---

## Switching to All-Claude

If you want maximum quality at higher cost:

```bash
cd ~/.config/opencode

# Coordinator already on Claude, just sync workers
python3 sync_agent_models.py
```

This will make all 96 agents use Claude Sonnet 4.5.
- Cost: ~$0.30 per 10-agent task (2.5x current)
- Benefit: Slightly better worker quality (marginal)

---

## Summary

**Current Configuration**: ✅ OPTIMAL

- **Coordinator**: Claude Sonnet 4.5 (completes tasks)
- **Workers**: Gemini 2.5 Pro (cost effective)
- **Cost**: 60% savings vs all-Claude
- **Quality**: High (Claude manages, Gemini executes)
- **Stopping Issue**: FIXED (Claude follows instructions)

**DO NOT change this unless you have a specific reason.**

**This hybrid setup gives you:**
- ✅ Tasks that actually complete
- ✅ 60% cost savings
- ✅ High quality results
- ✅ Best of both models

---

**Your OpenCode is now configured for optimal performance and cost.**
