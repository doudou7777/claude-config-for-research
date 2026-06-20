---
name: apa-checker
description: |
  This skill should be used when the user needs to check, fix, or format APA-style citations and references in academic papers. Use this skill when the user mentions: APA格式, APA引用, APA参考文献, 引用格式, 参考文献格式, 文献格式修改, APA修改, 格式错误, 引用错误, citation format, reference format, fix APA, check APA, APA 7th edition, 著者-出版年, 正文引用, 文献列表, in-text citation, reference list, 心理学报格式, 期刊引用格式, 学术引用, 文献标注. Covers both Chinese APA (心理学报 style) and English APA 7th Edition. Capable of identifying errors and providing corrected versions ready for direct use in manuscripts.
---

# APA 格式检查与修正 Skill

## 功能概述

专用于学术论文中 APA 格式的检查和修正，支持：
- **中文 APA 格式**（《心理学报》著者-出版年制，APA 7th 中文细化版本）
- **英文 APA 7th Edition**（2019年第7版）
- 同时处理正文引用（in-text citation）和文献列表（reference list）
- 识别常见错误并给出直接可用的修正结果

---

## 工作流程

### Step 1：加载参考文档

在开始检查之前，根据任务类型加载对应的参考文档：

- **中文文献/心理学报格式** → 读取 `references/chinese-apa.md`
- **英文文献/APA 7th** → 读取 `references/english-apa7.md`
- **快速错误定位** → 读取 `references/common-errors.md`

如果任务同时涉及中英文，全部三份文档都需要加载。

### Step 2：识别任务类型

根据用户输入，判断任务：

1. **单条/多条引用检查**：用户提供具体引用文字，逐条检查并修正。
2. **段落级检查**：用户粘贴论文段落，提取所有引用标志，逐一核查。
3. **文献列表检查**：用户提供文献列表，对每条条目进行格式核查。
4. **格式咨询**：用户询问某类文献的正确写法，给出模板和示例。

### Step 3：执行检查

对每条引用/文献条目：
1. 对照 `references/common-errors.md` 快速扫描是否命中常见错误。
2. 对照具体格式规则（`chinese-apa.md` 或 `english-apa7.md`）深度核查。
3. 记录所有发现的问题，注明错误类型和位置。

### Step 4：输出修正结果

以清晰的对照格式呈现：

```
【原文】Smith J, Jones K (2020). Effects of stress on memory. Journal of Psychology, 56(3): 234-256.

【问题】
1. 著者格式错误：名字未缩写，姓名间缺逗号
2. 年份未加括号
3. 文章标题应为句式大写
4. 期刊名和卷号应斜体（文字提示）
5. 页码范围应用 en dash（–），不用冒号后直接跟页码

【修正后】Smith, J., & Jones, K. (2020). Effects of stress on memory. *Journal of Psychology*, *56*(3), 234–256.
```

### Step 5：核查清单验收

完成修正后，对照 `references/common-errors.md` 末尾的"快速核查清单"做最终验收，确保无遗漏。

---

## 输出规范

### 格式修正输出

- 用"原文 → 修正后"格式对照呈现
- 对每处改动给出**简短说明**（便于用户理解规则，下次自查）
- 如有多处改动，编号列出
- 最终修正版本单独一行，方便直接复制到论文中

### 格式咨询输出

- 先给出**规则说明**（1-3句话）
- 再给出**具体模板**
- 最后给出**完整示例**（贴近用户实际场景）

### 批量处理输出

- 每条文献独立处理，编号对应
- 汇总问题统计（如：共发现 12 处错误，涉及 5 类问题）

---

## 重要规则提醒

### 中文 APA 特别注意

1. **括号内中文多作者**：用逗号，**不加 &**（如：张三, 李四, 2020）
2. **正文中文作者连接词**：句子成分用"和"，括号内不用"&"
3. **中文文献需附英文**：先英文，后中文放方括号，必须抄录原文英文，不得自行翻译
4. **页码符号**：用破折号"−"而非连字符"-"
5. **英文文献在中文正文中的引用**：保持英文姓名写法

### APA 7th 与旧版主要区别

| 项目 | 旧版（第6版及以前）| APA 7th（第7版）|
|------|-----------------|----------------|
| 作者数量阈值 | ≥6位用 et al. | 首次引用起，≥3位即用 et al. |
| 文献列表作者上限 | 超过6位截断 | 最多列出20位 |
| DOI 格式 | DOI: xxxxxxxxx | https://doi.org/xxxxxxxxx |
| 出版地 | 必须写 | 已取消 |
| 期刊文章卷期格式 | 卷(期) | 卷(期)，规则相同 |
| 一级标题 | 粗体居中 | 粗体居中（未变化）|

---

## 使用示例

**用户输入**：帮我检查这条参考文献格式是否正确

**助手应该**：
1. 读取 `references/english-apa7.md` 和 `references/common-errors.md`
2. 识别文献类型（期刊/书/章节等）
3. 逐项对照格式规则
4. 输出带说明的对照修正结果

**用户输入**：我的论文是中文的，参考了一篇中文文献，该怎么引用？

**助手应该**：
1. 读取 `references/chinese-apa.md`
2. 询问文献类型（期刊/学位论文/书等）
3. 提供对应模板和示例
