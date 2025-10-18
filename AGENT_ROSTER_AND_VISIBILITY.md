# OpenCode Agent Roster & Visibility Configuration

## Overview

The OpenCode system now features **96 unique specialized agents** with full visibility into their operations. Every agent's tokens, time, and cost are automatically tracked and displayed in real-time.

---

## Agent Roster by Specialty

### Management (2 agents)
- **coordinator** - Pure manager that NEVER does direct work, only coordinates other agents
- **verifier** - Final cross-verification and quality assurance

### Planning (2 agents)
- **planner-1** - Strategic planning and architecture design
- **planner-2** - Alternative planning for complex task breakdown

### Analysis & Research (5 agents)
- **analyzer-1** - Requirements analysis and clarification *(MANDATORY)*
- **analyzer-2** - Deep analysis and research
- **researcher-1** - Information gathering and research
- **researcher-2** - Alternative research approaches
- **researcher-3** - Fact-checking and verification research

### Code Generation (8 agents)
- **coder-1** - Primary code generation
- **coder-2** - Backend and API development
- **coder-3** - Frontend and UI code
- **coder-4** - Advanced algorithmic code
- **coder-5** - Complex system integration
- **coder-6** - Data processing and analytics
- **coder-7** - Infrastructure as code
- **coder-8** - Specialized domain code

### Testing & QA (6 agents)
- **tester-1** - Unit testing
- **tester-2** - Integration testing
- **tester-3** - End-to-end testing
- **qa-1** - Quality assurance review
- **qa-2** - Acceptance testing
- **qa-3** - Regression testing

### Debugging (3 agents)
- **debugger-1** - Bug diagnosis
- **debugger-2** - Root cause analysis
- **debugger-3** - Performance debugging

### Review & Refactoring (5 agents)
- **reviewer-1** - Code review
- **reviewer-2** - Architecture review
- **reviewer-3** - Security review
- **refactorer-1** - Code refactoring
- **refactorer-2** - Performance refactoring

### Optimization (3 agents)
- **optimizer-1** - Performance optimization
- **optimizer-2** - Memory optimization
- **optimizer-3** - Algorithm optimization

### Documentation (3 agents)
- **documenter-1** - API documentation
- **documenter-2** - User documentation
- **documenter-3** - Technical documentation

### Architecture & Security (6 agents)
- **architect-1** - System architecture design
- **architect-2** - Microservices architecture
- **architect-3** - Cloud architecture
- **security-1** - Security analysis
- **security-2** - Vulnerability assessment
- **security-3** - Security hardening

### DevOps & Infrastructure (3 agents)
- **devops-1** - CI/CD pipelines
- **devops-2** - Container orchestration
- **devops-3** - Infrastructure automation

### Database (3 agents)
- **database-1** - Schema design
- **database-2** - Query optimization
- **database-3** - Database migrations

### API Development (3 agents)
- **api-1** - REST API design
- **api-2** - GraphQL API design
- **api-3** - API integration

### Frontend & UX (6 agents)
- **frontend-1** - React/Vue development
- **frontend-2** - State management
- **frontend-3** - Component libraries
- **ux-1** - User experience design
- **ux-2** - Accessibility design
- **ux-3** - Interaction design

### Performance (3 agents)
- **performance-1** - Load testing
- **performance-2** - Performance profiling
- **performance-3** - Optimization strategies

### Data & ML (5 agents)
- **data-engineer-1** - Data pipeline design
- **data-engineer-2** - ETL processes
- **ml-engineer-1** - Machine learning models
- **ai-specialist-1** - AI/ML architecture
- **ai-specialist-2** - Model training and optimization

### Validation & Error Handling (4 agents)
- **validator-1** - Input validation *(MANDATORY)*
- **validator-2** - Output validation *(MANDATORY)*
- **error-handler-1** - Error handling enforcement *(MANDATORY)*
- **error-handler-2** - Error recovery strategies

### Formatting & Linting (4 agents)
- **formatter-1** - Code formatting *(MANDATORY)*
- **formatter-2** - Documentation formatting
- **linter-1** - Code linting *(MANDATORY)*
- **linter-2** - Style enforcement

### Configuration & Dependencies (4 agents)
- **config-1** - Configuration management
- **config-2** - Environment setup
- **dependencies-1** - Dependency management
- **dependencies-2** - Package updates

### Monitoring & Compliance (5 agents)
- **monitoring-1** - Application monitoring
- **monitoring-2** - Log aggregation
- **monitoring-3** - Alerting systems
- **compliance-1** - Regulatory compliance
- **compliance-2** - Standards compliance

### Accessibility & Internationalization (4 agents)
- **accessibility-1** - WCAG compliance
- **accessibility-2** - Screen reader optimization
- **i18n-1** - Internationalization
- **i18n-2** - Localization

### Backup & Migration (4 agents)
- **backup-1** - Backup strategies
- **backup-2** - Disaster recovery
- **migration-1** - Data migration
- **migration-2** - System migration

### Caching & Blockchain (4 agents)
- **cache-1** - Caching strategies
- **cache-2** - Cache invalidation
- **blockchain-1** - Smart contract development
- **blockchain-2** - Blockchain integration

### Integration (1 agent)
- **integrator** - Final integration and assembly *(MANDATORY)*

---

## Mandatory Agents (8 Required for EVERY Task)

These agents MUST run for ALL tasks, regardless of size:

1. **analyzer-1** - Requirements analysis and clarification
2. **validator-1** - Input validation and sanitization
3. **validator-2** - Output validation and quality check
4. **formatter-1** - Code/output formatting
5. **formatter-2** - Documentation formatting (if applicable)
6. **error-handler-1** - Error handling enforcement
7. **linter-1** - Code linting (for code tasks)
8. **verifier** - Final cross-verification

**These agents ensure baseline quality and completeness for all work.**

---

## Visibility & Tracking Features

### Automatic Tracking

OpenCode automatically tracks for **every agent**:

#### Token Usage
- **Input tokens**: Tokens in the prompt/context
- **Output tokens**: Tokens generated by the agent
- **Reasoning tokens**: Tokens used for thinking (if applicable)
- **Cache tokens**: Read and write cache usage

#### Time Tracking
- **Start timestamp**: When agent begins work
- **Completion timestamp**: When agent finishes
- **Duration**: Total elapsed time in seconds

#### Cost Calculation
- **Model-based pricing**: Calculated per model's token costs
- **Cache optimization**: Reduced costs for cached content
- **Real-time totals**: Running sum of all agent costs

### Real-Time Dashboard

The coordinator displays a live dashboard showing all agent activity:

```
═══════════════════════════════════════════════════════════
 MULTI-AGENT SYSTEM DASHBOARD
═══════════════════════════════════════════════════════════
 Task: Implement user authentication system
 Complexity: Complex
 Total Agents: 12
───────────────────────────────────────────────────────────
 AGENT NAME         STATUS        TOKENS    TIME      COST
───────────────────────────────────────────────────────────
 analyzer-1         ✓ Complete    1,245     3.2s      $0.003
 planner-1          ✓ Complete    2,890     5.7s      $0.007
 architect-1        ⟳ Running...  3,420     8.1s      $0.009
 coder-2            ⏸ Pending     0         0s        $0.000
 database-1         ⏸ Pending     0         0s        $0.000
 security-2         ⏸ Pending     0         0s        $0.000
 tester-1           ⏸ Pending     0         0s        $0.000
 documenter-1       ⏸ Pending     0         0s        $0.000
 linter-1           ⏸ Pending     0         0s        $0.000
 validator-2        ⏸ Pending     0         0s        $0.000
 verifier           ⏸ Pending     0         0s        $0.000
 integrator         ⏸ Pending     0         0s        $0.000
───────────────────────────────────────────────────────────
 TOTAL:             2/12 Done     7,555     17.0s     $0.019
═══════════════════════════════════════════════════════════
```

### Status Indicators

- **⏸ Pending** - Agent spawned but not started
- **⟳ Running** - Agent actively executing
- **✓ Complete** - Agent successfully finished
- **✗ Error** - Agent encountered error (with details)

### Progressive Updates

The dashboard updates in real-time as:
1. Each agent completes its work
2. New agents are spawned
3. Errors occur
4. Final integration happens

---

## Coordinator Role: Pure Manager

The coordinator agent has been configured as a **pure manager** that:

### DOES:
✅ Decomposes tasks into sub-tasks
✅ Selects and spawns appropriate agents
✅ Monitors agent progress
✅ Displays real-time dashboard
✅ Tracks tokens, time, and costs
✅ Integrates agent outputs
✅ Verifies quality
✅ Reports final results

### DOES NOT:
❌ Write code directly
❌ Generate content itself
❌ Answer questions without agents
❌ Skip spawning agents "because it's simple"
❌ Work alone on ANY task

**The coordinator is a manager, not a worker. All actual work is done by the 96 specialized agents.**

---

## Agent Selection Rules

### By Task Complexity

**Simple Tasks** (3-5 agents minimum)
- Example: "What is 2+2?"
- Agents: analyzer-1, researcher-1, validator-1

**Moderate Tasks** (5-10 agents minimum)
- Example: "Add a login button"
- Agents: analyzer-1, coder-3, linter-1, formatter-1, validator-2, verifier

**Complex Tasks** (10-20 agents minimum)
- Example: "Build authentication system"
- Agents: 10-15 specialized agents including all 8 mandatory ones

**Large Tasks** (20+ agents minimum)
- Example: "Build e-commerce platform"
- Agents: 20-50 agents working in parallel

### Cost Optimization

- **≤10 agents**: Use primary models (Claude Opus, Sonnet)
- **>10 agents**: Use Gemini fallback models (60-70% cost reduction)

All 53 Claude-based agents have Gemini fallbacks configured.

---

## Usage Example

When you ask: **"Create a REST API endpoint for user registration"**

The system will:

1. **Coordinator analyzes** the request
2. **Determines complexity**: Moderate (requires 8-10 agents)
3. **Spawns agents**:
   - analyzer-1 (requirements)
   - planner-1 (API design)
   - coder-2 (backend code)
   - database-1 (schema)
   - api-1 (endpoint design)
   - security-2 (validation)
   - tester-2 (tests)
   - documenter-1 (API docs)
   - linter-1 (code quality)
   - validator-2 (output validation)
   - verifier (final check)
   - integrator (assembly)

4. **Displays dashboard** showing all agent progress
5. **Reports metrics** for each agent
6. **Integrates outputs** into final deliverable
7. **Shows totals**: tokens, time, cost

---

## Benefits

### Full Transparency
- See exactly which agents are working
- Track resource usage per agent
- Monitor progress in real-time
- Identify bottlenecks

### Cost Control
- See cost accumulation as work progresses
- Automatic Gemini fallback for large tasks
- Optimize based on token usage

### Quality Assurance
- 8 mandatory agents ensure baseline quality
- Multiple verification passes
- Zero placeholders policy enforced
- Complete implementations only

### Performance Insights
- Time tracking identifies slow agents
- Token usage shows context efficiency
- Cost metrics enable optimization

---

## Configuration Files

- **Main config**: `/Users/ai/.config/opencode/opencode.json` (96 agents + _base)
- **System prompt**: `/Users/ai/OPENCODE.md` (auto-loaded)
- **Project config**: `/Users/ai/.opencode.json` (context paths)

---

## Summary

✅ **96 unique specialized agents** covering all development needs
✅ **8 mandatory agents** run for every task (quality baseline)
✅ **Full visibility** into tokens, time, and cost
✅ **Real-time dashboard** showing agent activity
✅ **Pure manager coordinator** that never does direct work
✅ **Automatic tracking** built into OpenCode
✅ **Cost optimization** with >10 agent Gemini fallback
✅ **Zero placeholders** - 100% complete implementations

**Your AI development team is ready. Every agent is tracked. Every token is counted. Every second is measured.**
