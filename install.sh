#!/bin/bash
set -e

KIRO_DIR="${HOME}/.kiro"
AGENTS_DIR="${KIRO_DIR}/agents"
SKILLS_DIR="${KIRO_DIR}/skills"
CONFIG_DIR="${KIRO_DIR}/xhs-douyin-publisher"
MCP_JSON="${KIRO_DIR}/settings/mcp.json"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🚀 Installing xhs-douyin-publisher agent..."
echo ""

# ── Step 1: Agent config ──
mkdir -p "$AGENTS_DIR"
cp "$SCRIPT_DIR/agents/xhs-douyin-publisher.json" "$AGENTS_DIR/"
echo "✅ Agent config installed"

# ── Step 2: Skills ──
mkdir -p "$SKILLS_DIR/xhs-content-creator"
cp "$SCRIPT_DIR/skills/xhs-content-creator/SKILL.md" "$SKILLS_DIR/xhs-content-creator/"
echo "✅ Skills installed"

# ── Step 3: User config ──
mkdir -p "$CONFIG_DIR"
if [ ! -f "$CONFIG_DIR/config.yaml" ]; then
  cp "$SCRIPT_DIR/config.example.yaml" "$CONFIG_DIR/config.yaml"
  echo "✅ Config template created (agent will guide you through setup)"
else
  echo "⏭️  Config already exists, skipping"
fi

# ── Step 4: Xiaohongshu MCP setup ──
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📱 小红书 MCP Server 配置"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check if already configured
if [ -f "$MCP_JSON" ] && python3 -c "import json; d=json.load(open('$MCP_JSON')); exit(0 if 'xiaohongshu-mcp' in d.get('mcpServers',{}) else 1)" 2>/dev/null; then
  echo "✅ xiaohongshu-mcp 已配置，跳过"
else
  echo ""
  echo "小红书自动发布需要 xiaohongshu MCP server。"
  echo "目前有几个社区实现可选："
  echo ""
  echo "  1) xpzouying/xiaohongshu-mcp  ⭐推荐 (Python, 功能最全, 活跃维护)"
  echo "     → github.com/xpzouying/xiaohongshu-mcp"
  echo ""
  echo "  2) 1uokun/xiaohongshu-mcp-js  (Node.js, 支持发布+登录)"
  echo "     → github.com/1uokun/xiaohongshu-mcp-js"
  echo ""
  echo "  3) 手动配置 (我已经有自己的 XHS MCP server)"
  echo ""
  echo "  s) 跳过 (以后再配置，agent 仍可用于内容生成)"
  echo ""
  read -p "请选择 [1/2/3/s]: " choice

  case "$choice" in
    1)
      echo ""
      echo "📦 xpzouying/xiaohongshu-mcp (推荐)"
      echo ""
      echo "安装方式："
      echo "  git clone https://github.com/xpzouying/xiaohongshu-mcp.git"
      echo "  cd xiaohongshu-mcp && pip install -e . && python -m xiaohongshu_mcp"
      echo ""
      echo "或使用 Docker："
      echo "  docker run -p 18060:18060 xpzouying/xiaohongshu-mcp"
      echo ""
      read -p "服务地址 (默认 http://localhost:18060/mcp): " mcp_url
      mcp_url="${mcp_url:-http://localhost:18060/mcp}"
      ;;
    2)
      echo ""
      echo "📦 1uokun/xiaohongshu-mcp-js (Node.js)"
      echo ""
      echo "安装方式："
      echo "  git clone https://github.com/1uokun/xiaohongshu-mcp-js.git"
      echo "  cd xiaohongshu-mcp-js && npm install && npm start"
      echo ""
      read -p "服务地址 (默认 http://localhost:3000/mcp): " mcp_url
      mcp_url="${mcp_url:-http://localhost:3000/mcp}"
      ;;
    3)
      echo ""
      read -p "请输入你的 XHS MCP server 地址: " mcp_url
      if [ -z "$mcp_url" ]; then
        echo "❌ 地址不能为空，跳过 MCP 配置"
        mcp_url=""
      fi
      ;;
    *)
      echo "⏭️  跳过 MCP 配置。你可以之后手动添加到 $MCP_JSON"
      mcp_url=""
      ;;
  esac

  if [ -n "$mcp_url" ]; then
    # Ensure mcp.json exists
    mkdir -p "$(dirname "$MCP_JSON")"
    if [ ! -f "$MCP_JSON" ]; then
      echo '{"mcpServers":{}}' > "$MCP_JSON"
    fi

    # Merge xiaohongshu-mcp into mcp.json
    python3 -c "
import json
with open('$MCP_JSON') as f:
    data = json.load(f)
data.setdefault('mcpServers', {})
data['mcpServers']['xiaohongshu-mcp'] = {
    'url': '$mcp_url',
    'disabled': False
}
with open('$MCP_JSON', 'w') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
print('✅ xiaohongshu-mcp 已添加到', '$MCP_JSON')
"
  fi
fi

# ── Done ──
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 安装完成！"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "使用方法："
echo "  kiro-cli chat"
echo "  /agent swap xhs-douyin-publisher"
echo ""
echo "首次使用时 agent 会引导你完成账号配置 🚀"
