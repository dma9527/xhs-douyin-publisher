#!/bin/bash
set -e

KIRO_DIR="${HOME}/.kiro"
AGENTS_DIR="${KIRO_DIR}/agents"
SKILLS_DIR="${KIRO_DIR}/skills"
CONFIG_DIR="${KIRO_DIR}/xhs-douyin-publisher"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🚀 Installing xhs-douyin-publisher agent..."

# Copy agent config
mkdir -p "$AGENTS_DIR"
cp "$SCRIPT_DIR/agents/xhs-douyin-publisher.json" "$AGENTS_DIR/"
echo "✅ Agent config → $AGENTS_DIR/"

# Copy skills
mkdir -p "$SKILLS_DIR/xhs-content-creator"
cp "$SCRIPT_DIR/skills/xhs-content-creator/SKILL.md" "$SKILLS_DIR/xhs-content-creator/"
echo "✅ Skill → $SKILLS_DIR/xhs-content-creator/"

# Setup config directory
mkdir -p "$CONFIG_DIR"
if [ ! -f "$CONFIG_DIR/config.yaml" ]; then
  cp "$SCRIPT_DIR/config.example.yaml" "$CONFIG_DIR/config.yaml"
  echo "✅ Config template → $CONFIG_DIR/config.yaml"
  echo ""
  echo "📝 两种方式完成配置："
  echo "   1. 直接编辑 $CONFIG_DIR/config.yaml"
  echo "   2. 在 Kiro 中对 agent 说 \"帮我配置账号\"，它会引导你完成"
else
  echo "⏭️  Config already exists, skipping"
fi

# MCP reminder
echo ""
echo "⚠️  还需要手动配置 xiaohongshu-mcp："
echo "   将 mcp/mcp-config-example.json 中的内容合并到 ~/.kiro/settings/mcp.json"
echo ""
echo "🎉 安装完成！使用方法："
echo "   kiro-cli chat"
echo "   /agent swap xhs-douyin-publisher"
