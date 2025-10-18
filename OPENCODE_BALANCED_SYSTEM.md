# OpenCode Multi-Agent System - Balanced Approach

## Overview

Your OpenCode system is configured with **96 specialized AI agents** (95 workers + 1 coordinator) that work together as a coordinated development team. The coordinator uses **intelligent delegation** - handling lightweight tasks directly but spawning agents for all actual work.

---

## Coordinator Role: Strategic Manager

### The coordinator is a **hybrid** that balances efficiency with multi-agent power:

```
┌─────────────────────────────────────────────────────────┐
│                  COORDINATOR ABILITIES                  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  LIGHTWEIGHT TASKS (Direct Response)                   │
│  ✅ Answer factual questions                           │
│  ✅ Provide explanations                               │
│  ✅ Analyze complexity                                 │
│  ✅ Decompose tasks                                    │
│  ✅ Select agents                                      │
│  ✅ Display dashboards                                 │
│  ✅ Integrate outputs                                  │
│                                                         │
│  ACTUAL WORK (Must Delegate)                           │
│  🔹 Code writing → coder agents                        │
│  🔹 Complex analysis → analyzer agents                 │
│  🔹 Testing → tester agents                            │
│  🔹 Documentation → documenter agents                  │
│  🔹 Debugging → debugger agents                        │
│  🔹 Security → security agents                         │
│  🔹 Database → database agents                         │
│  🔹 Any implementation → appropriate agents            │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## Decision Matrix

### When you ask something, the coordinator decides:

| Request Type | Coordinator Action | Agents Spawned |
|-------------|-------------------|----------------|
| **"What is REST API?"** | Answer directly | 0 (simple factual) |
| **"How does OAuth work?"** | Explain directly | 0 (explanation) |
| **"Write a REST API endpoint"** | Spawn agents | 10+ (implementation) |
| **"Debug this code"** | Spawn agents | 5+ (debugging) |
| **"Create user authentication"** | Spawn agents | 15+ (complex feature) |
| **"Build e-commerce site"** | Spawn agents | 30+ (large project) |
| **"Analyze this task"** | Do it yourself | 0 (coordination) |

### Decision Logic:

```python
if question_is_factual_or_simple_explanation:
    answer_directly()
elif task_requires_implementation:
    spawn_agents(min_count_based_on_complexity)
elif task_requires_technical_work:
    spawn_agents(min_count_based_on_complexity)
else:
    coordinate_and_monitor()
```

---

## Agent Spawning Rules

### Minimum Agent Counts:

| Task Complexity | Minimum Agents | Example |
|----------------|----------------|---------|
| **Simple** | 3-5 | Add a print statement |
| **Moderate** | 5-10 | Create a form component |
| **Complex** | 10-20 | Build authentication |
| **Large** | 20-50+ | Build full application |

### Always Include 8 Mandatory Agents (for work tasks):

1. **analyzer-1** - Requirements analysis
2. **validator-1** - Input validation
3. **validator-2** - Output validation
4. **formatter-1** - Code formatting
5. **formatter-2** - Documentation formatting
6. **error-handler-1** - Error handling
7. **linter-1** - Code quality
8. **verifier** - Final verification

---

## Agent Configuration in OpenCode

### All 95 agents are configured with:

```json
{
  "agent": {
    "_base": {
      "mode": "all",
      "temperature": 0.6,
      "permission": {
        "edit": "allow",
        "bash": {"*": "allow"},
        "webfetch": "allow"
      }
    },
    "coordinator": {
      "mode": "primary",
      "model": "anthropic/claude-sonnet-4-5",
      "description": "Strategic manager with selective delegation"
    },
    "coder-1": {
      "mode": "all",
      "model": "anthropic/claude-sonnet-4-5",
      "fallback_model": "google/gemini-2.5-flash",
      "description": "Primary code generation specialist"
    }
    // ... 94 more agents
  }
}
```

### Key Configuration Elements:

- **mode: "all"** - Agents can be invoked by coordinator AND act as primary agents
- **mode: "primary"** - Coordinator can spawn other agents
- **fallback_model** - Used when >10 agents spawn (cost optimization)
- **Permissions** - All agents can edit files, run bash, fetch web content
- **Inheritance** - All agents inherit from `_base` configuration

---

## Real-Time Visibility

### When agents work, you see everything:

```
═══════════════════════════════════════════════════════════
 MULTI-AGENT SYSTEM DASHBOARD
═══════════════════════════════════════════════════════════
 Task: Create REST API endpoint for user registration
 Complexity: Moderate
 Agents Spawned: 10
───────────────────────────────────────────────────────────
 AGENT NAME         STATUS        TOKENS    TIME      COST
───────────────────────────────────────────────────────────
 analyzer-1         ✓ Complete    1,245     3.2s      $0.003
 planner-1          ✓ Complete    2,340     5.1s      $0.006
 coder-2            ⟳ Running...  4,120     8.5s      $0.010
 database-1         ⏸ Pending     0         0s        $0.000
 api-1              ⏸ Pending     0         0s        $0.000
 security-2         ⏸ Pending     0         0s        $0.000
 tester-2           ⏸ Pending     0         0s        $0.000
 documenter-1       ⏸ Pending     0         0s        $0.000
 validator-2        ⏸ Pending     0         0s        $0.000
 verifier           ⏸ Pending     0         0s        $0.000
───────────────────────────────────────────────────────────
 TOTAL:             2/10 Done     7,705     16.8s     $0.019
═══════════════════════════════════════════════════════════
```

### OpenCode Built-in Tracking:

- **Tokens**: Input, output, reasoning, cache (read/write)
- **Time**: Start, complete, duration
- **Cost**: Calculated from token usage per model
- **Status**: Pending, Running, Complete, Error

---

## Example Workflows

### Example 1: Simple Question

**User:** "What is the difference between REST and GraphQL?"

**Coordinator Response:**
```
REST and GraphQL are both API architectural styles:

REST (Representational State Transfer):
- Uses HTTP methods (GET, POST, PUT, DELETE)
- Multiple endpoints for different resources
- Fixed data structure in responses
- Over-fetching or under-fetching common

GraphQL:
- Single endpoint
- Query language for data
- Clients specify exactly what data they need
- No over-fetching or under-fetching
- Strongly typed schema

Use REST for simple CRUD, GraphQL for complex data requirements.
```

**Agents Spawned:** 0 (simple explanation)

---

### Example 2: Moderate Implementation

**User:** "Create a REST API endpoint for user login"

**Coordinator Response:**
```
I'll coordinate the team to build this login endpoint.

Spawning 8 agents:
- analyzer-1: Requirements analysis
- coder-2: Backend endpoint implementation
- security-2: Authentication validation
- database-1: User lookup queries
- api-1: Endpoint specification
- tester-2: Unit and integration tests
- documenter-1: API documentation
- validator-2, verifier: Quality assurance

[Dashboard displays progress in real-time]

[After agents complete]

✓ Login endpoint created at POST /api/auth/login
✓ JWT token generation implemented
✓ Password validation with bcrypt
✓ Rate limiting configured
✓ Tests passing (12/12)
✓ Documentation complete

Total: 8 agents, 15,234 tokens, 42.3s, $0.038
```

**Agents Spawned:** 8

---

### Example 3: Complex Feature

**User:** "Implement complete user authentication system"

**Coordinator Response:**
```
Building full authentication system - this is complex.

Spawning 15 agents:

Planning (2):
- planner-1: System architecture
- architect-1: Security design

Implementation (5):
- coder-2: Backend routes
- coder-5: Middleware integration
- database-1: User schema
- database-2: Session storage
- api-1: Endpoint design

Security (2):
- security-2: Authentication logic
- security-3: Security hardening

Testing (3):
- tester-1: Unit tests
- tester-2: Integration tests
- qa-1: Security testing

Quality Assurance (3):
- documenter-1: API docs
- validator-2: Validation
- verifier: Final review

[Dashboard displays 15 agents working in parallel]

[After completion]

✓ Authentication system complete with:
  - User registration
  - Login/logout
  - JWT tokens
  - Refresh token rotation
  - Password reset
  - Email verification
  - Rate limiting
  - Security headers

Total: 15 agents, 38,452 tokens, 2m 18s, $0.095
```

**Agents Spawned:** 15

---

## Cost Optimization

### >10 Agents Rule

When spawning more than 10 agents, the system automatically uses cheaper models:

- **≤10 agents**: Use primary models (Claude Opus/Sonnet)
  - High quality for focused work
  - Cost: ~$3-5 per million tokens

- **>10 agents**: Use Gemini fallback models
  - Still high quality, faster
  - Cost: ~$1-2 per million tokens
  - **Savings: 60-70%**

### Example Cost Comparison:

| Scenario | Agents | Models Used | Tokens | Cost |
|----------|--------|-------------|--------|------|
| Small task | 5 | Claude | 10,000 | $0.030 |
| Medium task | 8 | Claude | 25,000 | $0.075 |
| Large task | 15 | Gemini fallback | 50,000 | $0.060 |
| Huge task | 30 | Gemini fallback | 100,000 | $0.120 |

Without fallback, the large task would cost $0.150 instead of $0.060 (40% savings).

---

## OpenCode Agent System Integration

### How It Works:

1. **User sends request** to OpenCode
2. **Coordinator analyzes** the request
3. **Decides:** Direct response or spawn agents?
4. **If spawning agents:**
   - Determines complexity
   - Selects appropriate agents
   - Spawns them with proper context
5. **OpenCode tracks** each agent automatically:
   - Token usage
   - Time elapsed
   - Cost calculation
6. **Dashboard updates** in real-time
7. **Coordinator integrates** agent outputs
8. **Delivers final result** to user

### Agent Invocation in OpenCode:

Agents are invoked using OpenCode's built-in agent system:

```
User message → Coordinator
             ↓
     Spawns sub-agents:
     - analyzer-1
     - coder-1
     - tester-1
     - ...
             ↓
    Each agent executes with full context
             ↓
    OpenCode tracks tokens/time/cost
             ↓
    Coordinator integrates outputs
             ↓
    User receives result
```

---

## Quality Assurance

### Zero Placeholders Policy

All agents must deliver **100% complete** implementations:

❌ **FORBIDDEN:**
```python
def authenticate(user):
    # TODO: Implement authentication
    pass
```

✅ **REQUIRED:**
```python
def authenticate(user):
    """Authenticate user with JWT token.

    Args:
        user: User object with credentials

    Returns:
        JWT token string or None if auth fails

    Raises:
        ValueError: If credentials invalid
    """
    if not user or not user.email:
        raise ValueError("Email required")

    # Verify password with bcrypt
    if not bcrypt.verify(user.password, user.hashed_password):
        return None

    # Generate JWT token
    payload = {
        'user_id': user.id,
        'email': user.email,
        'exp': datetime.utcnow() + timedelta(hours=24)
    }
    return jwt.encode(payload, SECRET_KEY, algorithm='HS256')
```

### 8 Mandatory Agents

These agents run for **every work task** to ensure quality:

1. **analyzer-1** - Understand requirements correctly
2. **validator-1** - Validate inputs
3. **validator-2** - Validate outputs
4. **formatter-1** - Format code properly
5. **formatter-2** - Format documentation
6. **error-handler-1** - Ensure error handling
7. **linter-1** - Check code quality
8. **verifier** - Final cross-check

---

## Configuration Files

| File | Purpose | Lines |
|------|---------|-------|
| `/Users/ai/.config/opencode/opencode.json` | Main agent configuration (96 agents) | ~2,900 |
| `/Users/ai/OPENCODE.md` | System instructions (auto-loaded) | 470 |
| `/Users/ai/.opencode.json` | Project settings | 25 |
| `/Users/ai/AGENT_ROSTER_AND_VISIBILITY.md` | Agent catalog | 400+ |

---

## Summary

### What You Get:

✅ **96 specialized AI agents** ready for any development task
✅ **Intelligent coordinator** that balances efficiency with power
✅ **Automatic delegation** for all implementation work
✅ **Full visibility** into tokens, time, and cost
✅ **Real-time dashboard** showing agent activity
✅ **8 mandatory QA agents** ensuring quality
✅ **Cost optimization** with automatic Gemini fallback
✅ **Zero placeholders** - only complete implementations

### How It Works:

1. **Simple questions** → Coordinator answers directly
2. **Explanations** → Coordinator provides directly
3. **Implementation work** → Coordinator spawns 3-50 agents
4. **Dashboard tracks** all agent activity in real-time
5. **Agents deliver** 100% complete work
6. **Coordinator integrates** and presents results

### Result:

**An AI development team that works like a real team:**
- Manager coordinates
- Workers do the work
- Quality is assured
- You see everything
- Nothing is hidden

---

## Ready to Use

Start OpenCode and ask anything:

```bash
opencode
```

The coordinator will intelligently decide whether to answer directly or spawn agents. You'll see the entire process unfold with complete transparency.

**Your AI development team is ready. Every agent has a role. Every action is tracked. Every result is complete.**
