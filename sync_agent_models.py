#!/usr/bin/env python3
"""
Sync all agent models to match the coordinator model.
If coordinator uses Claude, agents use Claude with extended thinking.
If coordinator uses non-Claude (e.g., Gemini), all agents use that model.
"""

import json
import sys

def is_claude_model(model):
    """Check if a model is a Claude model."""
    return model and 'claude' in model.lower()

def is_thinking_capable(model):
    """Check if a model supports extended thinking."""
    thinking_models = [
        'claude-opus-4',
        'claude-sonnet-4',
        'claude-3-7-sonnet',
        'claude-3-5-sonnet'
    ]
    return any(tm in model.lower() for tm in thinking_models)

def sync_models(config_path):
    """Sync all agent models to match coordinator."""

    # Read configuration
    with open(config_path, 'r') as f:
        config = json.load(f)

    # Get coordinator model
    coordinator_model = config['agent']['coordinator'].get('model')

    if not coordinator_model:
        print("❌ Error: Coordinator has no model set")
        sys.exit(1)

    print(f"📋 Coordinator model: {coordinator_model}")

    # Determine if using Claude
    using_claude = is_claude_model(coordinator_model)
    print(f"🤖 Model type: {'Claude' if using_claude else 'Non-Claude (e.g., Gemini)'}")

    # Determine if thinking is supported
    supports_thinking = is_thinking_capable(coordinator_model)
    print(f"🧠 Extended thinking: {'Enabled' if supports_thinking else 'Disabled'}")

    # Update all agents
    updated_count = 0
    thinking_enabled = 0
    thinking_disabled = 0

    for agent_name, agent_config in config['agent'].items():
        if agent_name in ('_base', 'coordinator'):
            continue

        # Set primary model to match coordinator
        old_model = agent_config.get('model')
        agent_config['model'] = coordinator_model

        # Remove fallback if not using Claude (or set to coordinator model)
        if 'fallback_model' in agent_config:
            if using_claude:
                # Keep Gemini fallback for >10 agents cost optimization
                pass
            else:
                # If not using Claude, no need for fallback
                del agent_config['fallback_model']

        # Handle extended thinking
        if supports_thinking:
            # Enable thinking for this agent
            if 'options' not in agent_config:
                agent_config['options'] = {}
            if not agent_config['options'].get('thinking'):
                agent_config['options']['thinking'] = True
                thinking_enabled += 1
        else:
            # Disable thinking if model doesn't support it
            if 'options' in agent_config and 'thinking' in agent_config['options']:
                del agent_config['options']['thinking']
                thinking_disabled += 1

        if old_model != coordinator_model:
            updated_count += 1

    # Update base configuration
    config['agent']['_base']['model'] = coordinator_model
    if supports_thinking:
        if 'options' not in config['agent']['_base']:
            config['agent']['_base']['options'] = {}
        config['agent']['_base']['options']['thinking'] = True
    else:
        if 'options' in config['agent']['_base'] and 'thinking' in config['agent']['_base']['options']:
            del config['agent']['_base']['options']['thinking']

    # Write back to file
    with open(config_path, 'w') as f:
        json.dump(config, f, indent=2)

    print(f"\n✅ Updated {updated_count} agents to use: {coordinator_model}")
    if thinking_enabled > 0:
        print(f"✅ Enabled extended thinking for {thinking_enabled} agents")
    if thinking_disabled > 0:
        print(f"✅ Disabled extended thinking for {thinking_disabled} agents")

    print(f"\n📊 Summary:")
    print(f"   Total agents: {len(config['agent']) - 2}")  # Exclude _base and coordinator
    print(f"   All using: {coordinator_model}")
    print(f"   Extended thinking: {'Enabled' if supports_thinking else 'Disabled'}")

    return True

if __name__ == '__main__':
    config_path = sys.argv[1] if len(sys.argv) > 1 else '/Users/ai/.config/opencode/opencode.json'

    print("═══════════════════════════════════════════════════════════")
    print("  OpenCode Agent Model Synchronization")
    print("═══════════════════════════════════════════════════════════")
    print()

    try:
        sync_models(config_path)
        print("\n✅ Configuration synchronized successfully!")
        print("\nAll agents now follow the coordinator's model.")
        print("═══════════════════════════════════════════════════════════")
    except Exception as e:
        print(f"\n❌ Error: {e}")
        sys.exit(1)
