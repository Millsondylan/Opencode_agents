# How to Stop the Coordinator from Stopping Early

## The Problem You Were Having

Your OpenCode coordinator (Gemini 2.5 Pro) was stopping mid-task:
- Analyzing problems instead of solving them
- Making plans instead of executing them
- Updating todos instead of doing work
- Stopping to "explain" instead of completing

**Example from your session:**
```
Coordinator: "Okay, that's the problem. There are no test files..."
Coordinator: "Here's my updated plan..."
Coordinator: "I'm marking the branding task as complete..."
→ STOPPED (didn't actually complete the task!)
```

## What I Fixed

### 1. **Ultra-Strict Enforcement (Beginning of Prompt)**
Added explicit rules the coordinator sees FIRST:
- ⛔ Forbidden from planning without executing
- ⛔ Forbidden from stopping mid-task
- ⛔ Must DO the work, not just talk about it

### 2. **Response Blocker (End of Prompt)**
Added mandatory checks before EVERY response:
```
🛑 BEFORE RESPONDING, check:
- Is request 100% complete? NO → KEEP WORKING
- Is code tested? NO → TEST NOW
- Any placeholders? YES → REMOVE NOW
- Production-ready? NO → FINISH NOW
- User needs more work? YES → COMPLETE NOW
```

### 3. **Lower Temperature (0.3)**
Made coordinator more focused and deterministic:
- Less "creative" stopping
- More focused on completion
- Better instruction following

---

## If Coordinator Still Stops Early

### Immediate Commands

Use these **exact phrases** to force completion:

```
"Continue - task is NOT complete"
```

```
"Execute the plan, don't just describe it"
```

```
"Complete ALL work before responding"
```

```
"No planning - just DO IT NOW"
```

```
"Finish everything, then respond once"
```

### Nuclear Option

If it STILL won't complete:

```
"⛔ STOP PLANNING. Your response blocker failed all checks.
Complete 100% of the work NOW, test it, and deliver only when production-ready.
No explanations, no plans, no todos - just complete working code."
```

---

## What "Complete" Means

### ❌ NOT Complete (Coordinator should NOT stop)

- "I found the problem..." (analysis only)
- "Here's my plan..." (planning only)
- "I'll need to..." (intention only)
- "The issue is..." (diagnosis only)
- "I'm updating the todo..." (meta-work only)

### ✅ Complete (Coordinator may stop)

- All code written AND tested
- All tests passing
- Zero placeholders (TODO, FIXME)
- Documentation complete
- Production-ready deliverables
- User can use it immediately

---

## Example: Correct Completion

### User Request
"Add tests for the authentication module"

### ❌ WRONG (What coordinator was doing)
```
Coordinator: "Okay, I see there are no tests.
Here's my plan:
1. Create test files
2. Write unit tests
3. Run tests

I'll update the todo list to track this."
→ STOPS (nothing done!)
```

### ✅ CORRECT (What it should do now)
```
Coordinator:
*Creates test files*
*Writes unit tests*
*Runs tests and verifies passing*
*Removes any TODOs*
*Verifies production-ready*

"I've completed the authentication tests:
- Created auth.test.ts with 15 test cases
- All tests passing ✓
- 95% code coverage
- Zero placeholders
- Production-ready

The test suite is complete and functional."
→ STOPS (after completing everything)
```

---

## Verification Commands

To check if coordinator has the new enforcement:

```bash
# Check ultra-strict enforcement exists
grep -c "ULTRA-STRICT COMPLETION ENFORCEMENT" ~/.config/opencode/opencode.json

# Check response blocker exists
grep -c "BEFORE YOU RESPOND - MANDATORY COMPLETION CHECK" ~/.config/opencode/opencode.json

# Both should return 1
```

---

## Configuration Changes Made

**File**: `/Users/ai/.config/opencode/opencode.json`

**Changes**:
1. Added ultra-strict enforcement at beginning of coordinator prompt
2. Added response blocker at end of coordinator prompt
3. Reduced coordinator temperature from 0.7 to 0.3
4. Enhanced base agent completion requirements

**Effect**: Coordinator now has THREE layers of completion enforcement:
- Layer 1: Ultra-strict rules (beginning)
- Layer 2: Original completion checklist (middle)
- Layer 3: Response blocker (end)

---

## Summary

### Before These Changes
- Coordinator stopped with plans instead of execution
- Analyzed problems instead of solving them
- Left work incomplete constantly
- Required constant "continue" commands

### After These Changes
- Coordinator must complete before responding
- Cannot stop with just plans or analysis
- Must test and verify all work
- Should require minimal intervention

### If It Still Stops
Use the command phrases above to force completion.

---

## Last Resort

If none of this works, the issue might be:

1. **Model limitation**: Gemini 2.5 Pro might not be following instructions
2. **Prompt too long**: Too many instructions might be confusing
3. **Need different model**: May need to switch coordinator to Claude Sonnet

**Solution**: Switch coordinator to Claude Sonnet 4.5:
```bash
# Edit opencode.json
"coordinator": {
  "model": "anthropic/claude-sonnet-4-5"
}

# Sync models (but keep workers on Gemini)
# Edit sync script to only change coordinator
```

---

**The coordinator now has maximum completion enforcement. It should stop early much less frequently.**
