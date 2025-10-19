# OpenCode Completion Enforcement

This document explains the completion enforcement system added to prevent the coordinator from stopping prematurely.

## Problem

The OpenCode coordinator was stopping before tasks were fully complete, leading to:
- Partial implementations
- Untested code
- Placeholders (TODO, FIXME)
- Incomplete deliverables

## Solution

Added **mandatory completion enforcement** to both the coordinator and all 96 worker agents.

---

## Coordinator Completion Checklist

The coordinator must verify ALL items before declaring task complete:

### Pre-Response Verification
1. ✅ All spawned agents have completed their work
2. ✅ All tasks are 100% finished (no partial work)
3. ✅ No placeholders or TODOs remain
4. ✅ All code/outputs actually work (tested)
5. ✅ All deliverables are production-ready
6. ✅ User's original request is FULLY satisfied

### Mandatory Checks Before Completion
- [ ] All spawned agents finished and returned outputs
- [ ] All code is complete and working (tested)
- [ ] All documentation is complete
- [ ] All tests pass
- [ ] No errors or warnings
- [ ] No placeholders (TODO, FIXME, etc.)
- [ ] User's original request is 100% satisfied
- [ ] All deliverables are production-ready

### Stopping Rules

**STOPPING IS ONLY ALLOWED WHEN:**
1. ✅ ALL checklist items are verified complete
2. ✅ User explicitly says "stop" or "that's enough"
3. ✅ You have confirmation task is 100% done

**NEVER STOP BECAUSE:**
- ❌ "Most of the work is done"
- ❌ "This should be sufficient"
- ❌ "The main parts are finished"
- ❌ "This is a good starting point"

---

## Worker Agent Requirements

Every worker agent must:

1. **Complete 100% of assigned task** (no partial work)
2. **Test all outputs** before returning
3. **Remove ALL placeholders** (TODO, FIXME, etc.)
4. **Deliver production-ready results** only
5. **Verify work actually functions** correctly

### Agent Pre-Return Checklist
- [ ] Task is 100% complete
- [ ] All code tested and working
- [ ] No placeholders remain
- [ ] All outputs are production-ready
- [ ] Work satisfies requirements completely

---

## What Changed

### Files Updated
- `/Users/ai/.config/opencode/opencode.json`
  - Coordinator prompt: Added completion enforcement section
  - Base agent prompt: Added completion requirements section
  - All 96 agents: Inherit completion requirements from base

### New Behaviors

**Before:**
- Coordinator could stop with "most work done"
- Partial implementations were acceptable
- Untested code could be delivered
- Placeholders were common

**After:**
- Coordinator MUST verify 100% completion
- Only complete, tested implementations
- Zero placeholders allowed
- Production-ready deliverables only

---

## How to Use

### For Users

When the coordinator stops, it should now:
1. Show completed work
2. Confirm ALL checklist items verified
3. Explicitly state task is 100% complete

If coordinator stops early:
- Tell it: "Complete the remaining work"
- Ask: "Is everything on the checklist verified?"
- Demand: "Finish all placeholders and test everything"

### For Debugging

If coordinator still stops early, check:

```bash
# Verify configuration has completion enforcement
grep -A 20 "COMPLETION ENFORCEMENT" opencode.json

# Check base agent has completion requirements
grep -A 10 "COMPLETION REQUIREMENTS" opencode.json
```

---

## Testing Completion Enforcement

Try these test cases:

### Test 1: Simple Task
```
Request: "Write a Python function to validate emails"

Expected:
- Function implemented
- Input validation added
- Error handling included
- Tests written
- Documentation complete
- All tested and working

NOT acceptable:
- Function only (no tests)
- TODO comments
- "This should work" without testing
```

### Test 2: Complex Task
```
Request: "Build a REST API endpoint for user registration"

Expected:
- Endpoint implemented
- Input validation
- Database integration
- Error handling
- Authentication
- Tests
- Documentation
- All tested and working

NOT acceptable:
- Partial implementation
- "Most features done"
- Untested code
```

---

## Enforcement Mechanism

### Coordinator Level
- Mandatory checklist before response
- Must verify all agent outputs
- Cannot declare completion without verification
- Required to test deliverables

### Agent Level
- Pre-return checklist required
- Must test before returning
- Cannot return partial work
- Must remove all placeholders

### System Level
- All 96 agents follow same rules
- Coordinator enforces standards
- No stopping until complete
- Quality over speed

---

## When to Override

The coordinator can stop early ONLY if:

1. **User explicitly says to stop**
   - "Stop here, that's enough"
   - "Cancel this task"
   - "Don't finish, just show what you have"

2. **User confirms partial is acceptable**
   - "Just give me a starting point"
   - "A draft is fine"
   - "Don't worry about testing"

3. **Task is truly impossible**
   - Ask user for clarification
   - Report why it can't be completed
   - Don't deliver incomplete as "complete"

---

## Summary

**Old behavior**: Stop when "mostly done"
**New behavior**: Stop ONLY when 100% complete and verified

This ensures OpenCode delivers:
- ✅ Complete implementations
- ✅ Tested code
- ✅ Production-ready work
- ✅ Zero placeholders
- ✅ Satisfied requirements

**The coordinator will no longer stop prematurely.**
