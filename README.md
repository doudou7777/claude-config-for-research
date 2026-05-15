# Claude Code Research Pack

学术科研工作流 Claude Code 配置包 — 包含 Agents、Commands、Skills、Rules、Hooks 和 Marketplace 配置。

## 一键部署

### Linux / macOS / WSL

```bash
git clone https://github.com/doudou7777/claude-research-pack.git
cd claude-research-pack
bash install.sh
```

### Windows PowerShell

```powershell
git clone https://github.com/doudou7777/claude-research-pack.git
cd claude-research-pack
.\install.ps1
```

### 安装后配置 Marketplace

安装完成后，还需注册外部 marketplace 并安装插件：

```bash
# 安装 nature-skills 插件
claude plugin install nature-skills@nature-skills
```

settings.template.json 已包含完整的 marketplace 和 plugin 配置，可参考合并到你的 settings.json。

---

## 包含内容

### 21 个 Agents（子代理）

| Agent | 用途 |
|-------|------|
| `planner` | 设计分析流程，拆解步骤，评估风险 |
| `code-reviewer` | 通用代码质量审查 |
| `python-reviewer` | Python 专属审查（PEP 8、numpy/pandas 最佳实践） |
| `security-reviewer` | 安全漏洞检测 |
| `tdd-guide` | 测试驱动开发指导 |
| `refactor-cleaner` | 清理死代码和重复逻辑 |
| `build-error-resolver` | 构建错误修复 |
| `code-explorer` | 快速理解开源工具代码结构 |
| `code-simplifier` | 简化复杂逻辑 |
| `silent-failure-hunter` | 发现静默失败和错误吞没 |
| `comment-analyzer` | 代码注释分析 |
| `conversation-analyzer` | 对话模式分析 |
| `harness-optimizer` | Agent harness 优化 |
| `loop-operator` | 自主循环运行管理 |
| `performance-optimizer` | 性能瓶颈分析 |
| `pr-test-analyzer` | PR 测试覆盖率审查 |
| `pytorch-build-resolver` | PyTorch 运行时错误修复 |
| `rebuttal-writer` | 论文审稿回复撰写 |
| `kaggle-miner` | Kaggle 竞赛辅助 |
| `literature-reviewer` | 文献审查 |
| `paper-miner` | 论文挖掘 |

### 51 个 Commands（斜杠命令）

**科研写作类：**
`/analyze-results` `/rebuttal` `/poster` `/presentation` `/paper-self-review` `/research-init` `/create_project`

**代码质量类：**
`/code-review` `/python-review` `/security-review` `/verify` `/quality-gate` `/build-fix` `/tdd`

**Git/版本控制类：**
`/commit` `/update-github` `/refactor-clean` `/checkpoint`

**知识管理类（Obsidian KB）：**
`/kb-init` `/kb-index` `/kb-ingest` `/kb-links` `/kb-lint` `/kb-sync` `/kb-status` `/kb-log` `/kb-map` `/kb-archive` `/kb-promote` `/kb-literature-review`
`/obsidian-init` `/obsidian-ingest` `/obsidian-note` `/obsidian-notes` `/obsidian-link` `/obsidian-sync` `/obsidian-review` `/obsidian-project` `/obsidian-views`
`/zotero-notes` `/zotero-review`

**学习与改进类：**
`/learn` `/evolve` `/hookify` `/mine-writing-patterns` `/harness-audit` `/cost-report` `/update-memory` `/update-readme`

**规划类：**
`/plan` `/setup-pm`

### 89 个 Skills（技能工作流）

**科研核心：**
`research-ideation` `deep-research` `research-ops` `results-analysis` `results-report` `literature-synthesis-guide` `keyword-literature-download`

**论文写作：**
`ml-paper-writing` `article-writing` `doc-coauthoring` `paper-self-review` `review-response` `writing-anti-ai` `citation-verification` `latex-conference-template-organizer`

**Nature 期刊全套（通过 nature-skills 插件）：**
`nature-academic-search` `nature-citation` `nature-data` `nature-figure` `nature-paper2ppt` `nature-polishing` `nature-reader` `nature-response` `nature-writing`

**数据与可视化：**
`ggplot2-richtext-fixes` `plotting-tool-selection` `publication-chart-skill` `raincloud-plot-guide` `r-scatter-plot-spec` `significance-group-scatter` `trait-environment-scatterplots` `weighted-data-pipeline` `weighted-regression-plot`

**开发与工程：**
`agent-architecture-audit` `agent-eval` `agent-harness-construction` `agent-identifier` `agent-introspection-debugging` `agent-reach` `agentic-engineering` `api-design` `architecture-design` `autonomous-agent-harness` `benchmark` `blueprint` `bug-detective` `code-review-excellence` `code-tour` `codebase-onboarding` `coding-standards` `command-development` `content-hash-cache-pattern` `context-budget` `continuous-agent-loop` `continuous-learning-v2` `cost-aware-llm-pipeline` `cost-tracking` `council` `daily-coding` `data-scraper-agent` `defuddle` `documentation-lookup` `git-workflow` `hook-development` `hypervolume-workflow` `karpathy-guidelines` `mcp-integration` `plugin-structure` `python-patterns` `python-testing` `repo-scan` `shell-choice-guide` `skill-creator` `skill-development` `skill-improver` `skill-quality-reviewer` `uv-package-manager` `verification-loop` `webapp-testing` `web-design-reviewer`

**前端/设计：**
`frontend-design` `frontend-slides` `ui-ux-pro-max` `ppt-production-guide`

**知识管理：**
`obsidian-kb-artifacts` `obsidian-literature-workflow` `obsidian-project-kb-core` `obsidian-source-ingestion` `zotero-obsidian-bridge`

**其他：**
`daily-paper-generator` `kaggle-learner` `master-thesis-studio-skill` `method-transfer-guide` `phylogeny-workflow` `post-acceptance`

### 18 个 Rules（自动规范）

**通用 (common/)：**
| Rule | 作用 |
|------|------|
| `claude-scholar-core.md` | Claude Scholar 核心行为规范 |
| `agents.md` | Agent 编排规则 |
| `code-review.md` | 代码审查标准 |
| `coding-style.md` | 通用编码风格（KISS、DRY、不可变性） |
| `development-workflow.md` | 开发全流程（plan → TDD → review → commit） |
| `experiment-reproducibility.md` | 实验可复现规范（种子、配置、环境记录） |
| `git-workflow.md` | Git 提交和 PR 规范 |
| `hooks.md` | Hooks 系统使用规范 |
| `patterns.md` | 设计模式 |
| `performance.md` | 性能优化和模型选择策略 |
| `security.md` | 安全检查清单 |
| `testing.md` | 测试要求（TDD, 80% 覆盖率） |

**Python (python/)：**
| Rule | 作用 |
|------|------|
| `coding-style.md` | PEP 8、black/ruff/mypy 规范 |
| `fastapi.md` | FastAPI 最佳实践 |
| `hooks.md` | Python hooks 规范 |
| `patterns.md` | Python 设计模式 |
| `security.md` | Python 安全检查 |
| `testing.md` | Python 测试规范 |

### 7 个 Hooks

| Hook | 触发时机 |
|------|----------|
| `security-guard.js` | PreToolUse — Bash/Write/Edit 安全检查 |
| `session-start.js` | SessionStart — 会话初始化 |
| `session-summary.js` | SessionEnd — 会话摘要 |
| `stop-summary.js` | Stop — 停止时摘要 |
| `skill-forced-eval.js` | UserPromptSubmit — 强制 skill 匹配 |
| `hook-common.js` | 通用 hook 工具函数 |
| `hooks.json` | Hook 配置元数据 |

---

## 插件与 Marketplace

本配置包依赖以下外部插件：

| Plugin | Marketplace | 提供内容 |
|--------|------------|----------|
| `nature-skills` | `Yuan1z0825/nature-skills` | 9 个 Nature 期刊学术 skill |
| `andrej-karpathy-skills` | `forrestchang/andrej-karpathy-skills` | Karpathy 编程指南 |
| `superpowers` | `claude-plugins-official` | 开发超能力工作流 |
| `document-skills` | `anthropic-agent-skills` | Office 文档处理 |
| `github` | `claude-plugins-official` | GitHub 集成 |

---

## 使用示例

```
# 文献调研
帮我 deep research 一下 diffusion models for protein design

# 论文写作（Nature 标准）
/nature-writing 帮我写这篇 paper 的 Introduction

# 论文润色
/nature-polishing 把这段摘要润色成 Nature 风格

# 论文图表
/nature-figure 画一张对比实验结果的柱状图

# 开始分析项目
/plan 我要做基于 ICA 的静息态网络分析

# 代码审查
/code-review

# 组会 PPT
/nature-paper2ppt 把这篇论文转成组会汇报 PPT

# 审稿回复
/rebuttal 根据 reviewer 意见写回复

# 提交代码
/commit
```

---

## 常见问题

**Q: 安装后没有生效？**
重启 Claude Code 即可。

**Q: 只想装某几个模块？**
手动复制对应文件到 `~/.claude/`，或删掉不需要的目录再运行 install.sh。

**Q: 和已有的 Claude Code 配置冲突？**
安装脚本会自动备份被覆盖的文件到 `~/.claude/backups/`。

**Q: Nature skills 需要额外安装？**
是，运行 `claude plugin install nature-skills@nature-skills` 安装插件。

**Q: Zotero 集成怎么配置？**
在 settings.json 的 `mcpServers.zotero.env` 中填入你的 ZOTERO_API_KEY 和 ZOTERO_LIBRARY_ID。

---

## License

MIT
