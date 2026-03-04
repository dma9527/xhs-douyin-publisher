# xhs-douyin-publisher

小红书 + 抖音内容发布 Agent，基于 [Kiro CLI](https://kiro.dev)。

[![Add to Kiro](https://img.shields.io/badge/Add_to-Kiro-blue)](https://kiro.dev/launch/mcp/add?name=skillport&config=%7B%22command%22%3A%22uvx%22%2C%22args%22%3A%5B%22skillport-mcp%22%5D%2C%22env%22%3A%7B%22SKILLPORT_SKILLS_DIR%22%3A%22~/.skillport/skills%22%7D%7D)

## 功能

- 🔴 **小红书**：自动发布（图文/视频），定时排期，标签优化
- 🎵 **抖音**：内容生成 + 打包（需手动上传，无公开 API）
- 🔄 **跨平台**：同一话题自动适配两个平台的风格差异
- ✍️ **内容创作 Skill**：内置小红书写作指南（标题公式、正文结构、标签策略）
- 🧭 **引导式配置**：首次使用时 agent 对话引导你完成账号设置

## 安装

### 方式 1：SkillPort（推荐）

如果你已安装 [SkillPort](https://github.com/gotalab/skillport)：

```bash
skillport add dma9527/xhs-douyin-publisher skills
```

### 方式 2：一键脚本

```bash
git clone https://github.com/dma9527/xhs-douyin-publisher.git
cd xhs-douyin-publisher
./install.sh
```

脚本会自动安装 agent、skill，并引导你配置小红书 MCP server。

### 方式 3：手动安装

```bash
# Agent
cp agents/xhs-douyin-publisher.json ~/.kiro/agents/

# Skill
mkdir -p ~/.kiro/skills/xhs-content-creator
cp skills/xhs-content-creator/SKILL.md ~/.kiro/skills/xhs-content-creator/

# Config
mkdir -p ~/.kiro/xhs-douyin-publisher
cp config.example.yaml ~/.kiro/xhs-douyin-publisher/config.yaml
```

## 小红书 MCP Server

自动发布功能需要一个 xiaohongshu MCP server。推荐选项：

| 项目 | 语言 | 特点 | 链接 |
|------|------|------|------|
| **xpzouying/xiaohongshu-mcp** ⭐ | Python | 功能最全，活跃维护，creator 工作流 | [GitHub](https://github.com/xpzouying/xiaohongshu-mcp) |
| 1uokun/xiaohongshu-mcp-js | Node.js | 轻量，支持发布+登录 | [GitHub](https://github.com/1uokun/xiaohongshu-mcp-js) |

运行 `./install.sh` 时会引导你选择和配置。

## 使用

```bash
kiro-cli chat
/agent swap xhs-douyin-publisher
```

### 首次使用 — 引导配置

Agent 会自动检测到你还没有配置，通过对话一步步引导你：

```
Agent: 👋 欢迎！我需要先了解一下你的账号信息。
Agent: 你的账号叫什么名字？
You:   信号塔Tech
Agent: 你的账号主要做什么领域？
You:   AI科技
Agent: ✅ 配置完成！随时说 "更新配置" 来修改。
```

也可以直接编辑：`~/.kiro/xhs-douyin-publisher/config.yaml`

### 日常使用

- "帮我写一篇关于 Claude 新功能的小红书"
- "这个话题同时发小红书和抖音"
- "搜索一下小红书上 AI 相关的热门帖子"

## 配置说明

| 配置项 | 说明 | 示例 |
|--------|------|------|
| `account.name` | 账号名称 | "信号塔Tech"、"小美食记" |
| `niche.primary` | 主领域 | "AI科技"、"美食探店"、"穿搭" |
| `niche.topics` | 具体话题 | ["大模型", "ChatGPT"] |
| `style.tone` | 写作风格 | casual / professional / playful / minimal |
| `tags.always` | 固定标签 | ["AI", "科技"] |
| `tags.pool` | 标签池 | ["人工智能", "ChatGPT"] |
| `publishing.preferred_slots` | 发布时段 | ["evening", "lunch"] |

## 项目结构

```
├── agents/
│   └── xhs-douyin-publisher.json   # Agent 配置
├── skills/
│   └── xhs-content-creator/
│       └── SKILL.md                # 小红书内容创作指南（SkillPort 兼容）
├── mcp/
│   └── mcp-config-example.json     # MCP 配置参考
├── config.example.yaml             # 账号配置模板
├── install.sh                      # 一键安装脚本
└── README.md
```

## License

MIT

---

# xhs-douyin-publisher (English)

Kiro CLI agent for publishing content to Xiaohongshu (小红书) and Douyin (抖音).

## Features

- 🔴 **Xiaohongshu**: Auto-publish with scheduled posting and tag optimization
- 🎵 **Douyin**: Content generation + packaging (manual upload, no public API)
- 🔄 **Cross-platform**: Adapts content for each platform's style
- ✍️ **Writing skill**: Built-in XHS content creation guide
- 🧭 **Guided setup**: Agent walks you through account configuration on first use

## Install

```bash
# Via SkillPort (recommended)
skillport add dma9527/xhs-douyin-publisher skills

# Or via script
git clone https://github.com/dma9527/xhs-douyin-publisher.git
cd xhs-douyin-publisher && ./install.sh
```

## XHS MCP Server

Auto-publishing requires a xiaohongshu MCP server:

| Project | Recommended | Link |
|---------|-------------|------|
| **xpzouying/xiaohongshu-mcp** | ⭐ Yes | [GitHub](https://github.com/xpzouying/xiaohongshu-mcp) |
| 1uokun/xiaohongshu-mcp-js | | [GitHub](https://github.com/1uokun/xiaohongshu-mcp-js) |

## Usage

```bash
kiro-cli chat
/agent swap xhs-douyin-publisher
```
