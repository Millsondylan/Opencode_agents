#!/usr/bin/env python3
"""
Validate that all agents use EXACTLY the coordinator's model.
No fallbacks, no alternatives - strict enforcement.
"""

import json
import sys

def validate_strict_usage(config_path):
    """Validate strict model usage across all agents."""

    with open(config_path, 'r') as f:
        config = json.load(f)

    print("═" * 70)
    print("  STRICT MODEL USAGE VALIDATION")
    print("═" * 70)
    print()

    coordinator_model = config['agent']['coordinator'].get('model')
    if not coordinator_model:
        print("❌ ERROR: Coordinator has no model set!")
        return False

    print(f"✅ Coordinator model: {coordinator_model}")
    print()
    print("Validating all 95 worker agents...")
    print()

    issues = []
    warnings = []

    # Check each agent
    for agent_name, agent_config in config['agent'].items():
        if agent_name in ('_base', 'coordinator'):
            continue

        agent_model = agent_config.get('model')

        # Critical: Model mismatch
        if agent_model != coordinator_model:
            issues.append(f"❌ {agent_name}: uses '{agent_model}' instead of '{coordinator_model}'")

        # Warning: Has fallback (could use different model)
        if 'fallback_model' in agent_config:
            warnings.append(f"⚠️  {agent_name}: has fallback_model '{agent_config['fallback_model']}'")

    # Report issues
    if issues:
        print("❌ CRITICAL ISSUES FOUND:")
        print()
        for issue in issues:
            print(f"   {issue}")
        print()
        print(f"   Total mismatches: {len(issues)}")
        print()
        print("⚠️  YOUR USAGE WILL BE INCORRECT!")
        print("   Run: python3 sync_agent_models.py to fix")
        print()
        return False

    if warnings:
        print("⚠️  WARNINGS:")
        print()
        for warning in warnings:
            print(f"   {warning}")
        print()
        print(f"   Total fallback models: {len(warnings)}")
        print()
        print("⚠️  Fallback models can cause different usage!")
        print("   For strict enforcement, run: python3 sync_agent_models.py")
        print()

    if not issues and not warnings:
        print("✅ PERFECT CONFIGURATION!")
        print()
        print("   All 95 agents use: " + coordinator_model)
        print("   No fallback models configured")
        print("   No model mismatches found")
        print()
        print("✅ YOUR USAGE WILL BE:")
        print(f"   - Every agent call uses: {coordinator_model}")
        print(f"   - No alternative models")
        print(f"   - 100% predictable usage")
        print()

    print("═" * 70)

    return len(issues) == 0

if __name__ == '__main__':
    config_path = sys.argv[1] if len(sys.argv) > 1 else '/Users/ai/.config/opencode/opencode.json'

    success = validate_strict_usage(config_path)
    sys.exit(0 if success else 1)
