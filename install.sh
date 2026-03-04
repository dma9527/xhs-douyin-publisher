#!/bin/bash
set -e

KIRO_DIR="${HOME}/.kiro"
AGENTS_DIR="${KIRO_DIR}/agents"
SKILLS_DIR="${KIRO_DIR}/skills"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🚀 Installing xhs-douyin-publisher agent..."

# Copy agent config
mkdir -p "$AGENTS_DIR"
cp "$SCRIPT_DIR/agents/xhs-douyin-publisher.json" "$AGENTS_DIR/"
echo "✅ Agent config → $AGENTS_DIR/xhs-douyin-publisher.json"

# Copy skills
mkdir -p "$SKILLS_DIR/xhs-content-creator"
cp "$SCRIPT_DIR/skills/xhs-content-creator/SKILL.md" "$SKILLS_DIR/xhs-content-creator/"
echo "✅ Skill → $SKILLS_DIR/xhs-content-creator/SKILL.md"

# MCP reminder
echo ""
echo "⚠️  还需要手动配置 xiaohongshu-mcp："
echo "   将 mcp/mcp-config-example.json 中的内容合并到 ~/.kiro/settings/mcp.json"
echo ""
echo "🎉 安装完成！使用方法："
echo "   kiro-cli chat"
echo "   /agent swap xhs-douyin-publisher"
