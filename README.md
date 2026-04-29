# Claude Code Research Pack

从 [everything-claude-code](https://github.com/affaan-m/everything-claude-code) 精选的科研工作流配置包，专为**脑影像分析、数据科学、文献阅读与汇报**场景定制。

## 一键部署

### Linux / macOS / WSL

```bash
git clone https://github.com/YOUR_USER/claude-research-pack.git
cd claude-research-pack
bash install.sh
```

### Windows PowerShell

```powershell
git clone https://github.com/YOUR_USER/claude-research-pack.git
cd claude-research-pack
.\install.ps1
```

### 手动复制（如果只想装部分）

```bash
cp -r agents/*   ~/.claude/agents/
cp -r commands/* ~/.claude/commands/
cp -r skills/*   ~/.claude/skills/
cp -r rules/common/* ~/.claude/rules/
```

安装后**重启 Claude Code** 即可生效。

---

## 包含内容

### 8 个 Agents（子代理）

| Agent | 科研用途 |
|-------|----------|
| `planner` | 设计 fMRI/MRI 分析流程，拆解步骤，评估风险 |
| `code-reviewer` | 通用代码质量审查 |
| `python-reviewer` | Python 专属审查（PEP 8、类型注解、numpy/pandas 最佳实践） |
| `refactor-cleaner` | 清理和整理面条式分析脚本 |
| `code-explorer` | 快速理解开源工具代码结构（nilearn、fMRIPrep 等） |
| `code-simplifier` | 简化复杂逻辑，提升代码可读性 |
| `silent-failure-hunter` | 发现分析脚本中静默失败（数据处理 bug 高发区） |
| `comment-analyzer` | 分析和改进代码注释 |

### 6 个 Commands（斜杠命令）

| 命令 | 用途 |
|------|------|
| `/plan` | 先规划再写代码，自动生成分析流程设计书 |
| `/code-review` | 审查分析脚本的逻辑错误和统计方法问题 |
| `/python-review` | Python 专属审查 |
| `/learn` | 从当前会话中提取可复用的模式 |
| `/verify` | 跑完分析后验证结果合理性 |
| `/refactor-clean` | 安全删除死代码 + 合并重复逻辑 |

### 12 个 Skills（技能工作流）

| Skill | 用途 |
|-------|------|
| `research-ops` | 研究工作流编排（搜索 → 综合 → 推荐） |
| `deep-research` | 多源深度文献调研，生成含引用报告 |
| `article-writing` | 撰写论文、教程、技术博客 |
| `frontend-slides` | 创建 HTML 演示文稿（组会汇报） |
| `python-patterns` | Python 最佳实践、类型注解、设计模式 |
| `python-testing` | Python 测试编写指导 |
| `code-tour` | 为代码库创建引导式导览 |
| `repo-scan` | 扫描和分析新代码库结构 |
| `verification-loop` | 代码验证检查流程 |
| `git-workflow` | Git 版本控制工作流 |
| `data-scraper-agent` | 数据采集工具 |
| `documentation-lookup` | 文档查阅 |

### 5 个 Rules（自动规范）

| Rule | 作用 |
|------|------|
| `coding-style.md` | 通用编码风格（KISS、DRY、不可变性） |
| `code-review.md` | 代码审查标准（已适配科研场景，放松覆盖率要求） |
| `security.md` | 安全检查清单（API key、数据隐私） |
| Python: `coding-style.md` | PEP 8、black/ruff/mypy 规范 |
| Python: `patterns.md` | Python 特定设计模式 |

---

## 与原版 everything-claude-code 的区别

| | 原版 ECC | Research Pack |
|------|----------|---------------|
| Agents | 48 个 | 8 个（只留科研相关） |
| Commands | 79 个 | 6 个 |
| Skills | 183 个 | 12 个 |
| 语言 | 12 种 | Python 为主 |
| TDD 覆盖率要求 | 强制 80% | 放宽（科研代码不适用） |
| 工程化（K8s/CI/CD） | 大量 | 全部移除 |
| Context 负担 | 重 | 轻 |

---

## 使用示例

```
# 开始一个新的 fMRI 分析项目
/plan 我要做基于 ICA 的静息态网络分析，
      数据来自 ABCD study，预处理用 fMRIPrep 完成

# 审查分析脚本
/code-review

# 调研某个方法
帮我 deep research 一下 dynamic functional connectivity 的最新方法

# 组会汇报
帮我把这个分析结果做成 HTML 幻灯片
```

---

## 常见问题

**Q: 安装后没有生效？**
重启 Claude Code 即可。

**Q: 只想装某几个模块？**
手动复制对应文件到 `~/.claude/`，或者把不需要的删掉再运行 install.sh。

**Q: 和已有的 Claude Code 配置冲突？**
安装脚本会自动备份被覆盖的文件到 `~/.claude/backups/`。

**Q: 我是 R/MATLAB 用户，这个包有用吗？**
code-reviewer 和 planner 是语言无关的，但 Python rules/skills 占比较高。你可以只装 agents 和 commands，跳过 Python 特定的 rules。

---

## License

MIT (same as everything-claude-code)
