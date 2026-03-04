# xhs-douyin-publisher

小红书 + 抖音内容发布 Agent，基于 [Kiro CLI](https://kiro.dev)。

## 功能

- 🔴 **小红书**：自动发布（图文/视频），定时排期，标签优化
- 🎵 **抖音**：内容生成 + 打包（需手动上传，无公开 API）
- 🔄 **跨平台**：同一话题自动适配两个平台的风格差异
- ✍️ **内容创作 Skill**：内置科技类小红书写作指南（标题公式、正文结构、标签策略）

## 前置要求

- [Kiro CLI](https://kiro.dev) 已安装
- [xiaohongshu-mcp](https://github.com) 已配置（小红书自动发布需要）

## 安装

```bash
git clone https://github.com/dma9527/xhs-douyin-publisher.git
cd xhs-douyin-publisher
./install.sh
```

安装脚本会将 agent 和 skill 复制到 `~/.kiro/` 对应目录。

### 手动配置 MCP

将 `mcp/mcp-config-example.json` 中的内容合并到你的 `~/.kiro/settings/mcp.json`：

```json
{
  "mcpServers": {
    "xiaohongshu-mcp": {
      "command": "npx",
      "args": ["-y", "xiaohongshu-mcp"]
    }
  }
}
```

## 使用

```bash
kiro-cli chat
/agent swap xhs-douyin-publisher
```

然后直接说：
- "帮我写一篇关于 Claude 新功能的小红书"
- "这个话题同时发小红书和抖音"
- "搜索一下小红书上 AI 相关的热门帖子"

## 项目结构

```
├── agents/
│   └── xhs-douyin-publisher.json   # Agent 配置
├── skills/
│   └── xhs-content-creator/
│       └── SKILL.md                # 小红书内容创作指南
├── mcp/
│   └── mcp-config-example.json     # MCP 配置参考
├── install.sh                      # 一键安装脚本
└── README.md
```

## 工作流程

### 小红书（自动发布）

1. 告诉 agent 你想发什么 → 生成标题 + 文案 + 标签
2. 预览确认 → 你说 OK 才会发
3. 自动排期到北京时间高峰时段（08:00 / 12:00 / 20:00 / 21:30）

### 抖音（内容准备）

1. 告诉 agent 你想发什么 → 生成标题 + 文案 + 标签 + 封面建议
2. 所有素材保存到 `social/{date}/douyin/` 目录
3. 你手动上传到抖音 app

## License

MIT

---

# xhs-douyin-publisher (English)

A Kiro CLI agent for publishing content to Xiaohongshu (小红书) and Douyin (抖音).

## Features

- 🔴 **Xiaohongshu**: Auto-publish (image/video posts), scheduled posting, tag optimization
- 🎵 **Douyin**: Content generation + packaging (manual upload required, no public API)
- 🔄 **Cross-platform**: Adapts same topic for both platforms' style differences
- ✍️ **Content creation skill**: Built-in writing guide for tech content on XHS

## Prerequisites

- [Kiro CLI](https://kiro.dev) installed
- [xiaohongshu-mcp](https://github.com) configured (required for XHS auto-publish)

## Install

```bash
git clone https://github.com/dma9527/xhs-douyin-publisher.git
cd xhs-douyin-publisher
./install.sh
```

Then manually merge `mcp/mcp-config-example.json` into your `~/.kiro/settings/mcp.json`.

## Usage

```bash
kiro-cli chat
/agent swap xhs-douyin-publisher
```
