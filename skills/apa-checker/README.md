# apa-checker 📚

> WorkBuddy Skill for checking, fixing, and formatting APA-style citations and references in academic papers.

A specialized skill that turns your AI assistant into an APA formatting expert. Supports both **Chinese APA** (《心理学报》author-year style) and **English APA 7th Edition**. Identifies errors and provides corrected versions ready for direct use in manuscripts.

---

## ✨ Features

- 🔍 **Error Detection** — Scans in-text citations and reference lists for APA format violations
- ✏️ **Auto-Fix** — Provides corrected versions with clear explanations for each change
- 🇨🇳🇺🇸 **Bilingual Support** — Covers Chinese APA (心理学报 style) and English APA 7th Edition
- 📋 **Common Errors Cheatsheet** — Built-in quick-reference for the most frequent APA mistakes
- 📖 **Format Consultation** — Ask how to format any reference type and get templates + examples

---

## 📂 Skill Structure

```
apa-checker/
├── SKILL.md                        # Main skill file (triggers, workflow, output spec)
├── README.md                       # This file
├── LICENSE                         # MIT License
├── references/
│   ├── chinese-apa.md              # Chinese APA rules (心理学报 author-year system)
│   ├── english-apa7.md             # English APA 7th Edition rules
│   └── common-errors.md            # Common errors cheatsheet (Chinese & English)
├── assets/                         # (reserved for templates)
└── scripts/                        # (reserved for automation scripts)
```

---

## 🚀 Installation

### Option 1: Install from this repo

1. Clone this repository:
   ```bash
   git clone https://github.com/sheep-psy/apa-checker.git
   ```

2. Copy to your WorkBuddy skills directory:
   ```bash
   # User-level (recommended, available across all projects)
   cp -r apa-checker/ ~/.workbuddy/skills/apa-checker/

   # OR project-level (shared with team)
   cp -r apa-checker/ .workbuddy/skills/apa-checker/
   ```

3. Restart WorkBuddy or start a new conversation — the skill will be auto-detected.

### Option 2: Install from .zip

1. Download the latest release `.zip` file
2. Extract and copy the `apa-checker/` folder to `~/.workbuddy/skills/`
3. Restart WorkBuddy

---

## 📖 Usage

Once installed, simply talk to WorkBuddy in natural language:

| What you say | What happens |
|---|---|
| "帮我检查这条参考文献格式" | Skill auto-triggers, checks and corrects the reference |
| "这段引用格式对吗？" | Checks in-text citations in the paragraph |
| "APA 7th的DOI怎么写？" | Format consultation with template + example |
| "我的中文论文引用该怎么写？" | Loads Chinese APA rules and provides guidance |
| "check APA format" / "fix APA" | Also triggers the skill |

### Example Output

```
【原文】Smith J, Jones K (2020). Effects of stress on memory. Journal of Psychology, 56(3): 234-256.

【问题】
1. 著者格式错误：名字未缩写，姓名间缺逗号
2. 年份未加括号
3. 文章标题应为句式大写
4. 期刊名和卷号应斜体
5. 页码范围应用 en dash（–）

【修正后】Smith, J., & Jones, K. (2020). Effects of stress on memory. Journal of Psychology, 56(3), 234–256.
```

---

## 📋 Covered Reference Types

### English APA 7th
- Journal articles (1–20+ authors)
- Books & edited books
- Book chapters
- Dissertations / theses
- Web pages & online resources
- Conference presentations
- Reports & gray literature
- Social media posts
- Software & apps

### Chinese APA (心理学报)
- 中文期刊论文
- 英文期刊论文
- 专著
- 编著/论文集
- 学位论文
- 网络文献
- 报纸文章

---

## 🔧 How It Works

The skill follows a 5-step workflow:

1. **Load references** — Picks the right rule document based on your task (Chinese/English/both)
2. **Identify task type** — Single citation, paragraph, reference list, or consultation
3. **Execute check** — Scans against common errors first, then deep-checks against full rules
4. **Output corrections** — Presents "original → corrected" with explanations
5. **Verify** — Runs through a final checklist to ensure nothing is missed

---

## 🤝 Contributing

Contributions are welcome! Especially:

- New error patterns for `references/common-errors.md`
- Updates when APA releases new guidelines
- Translations for other citation styles (MLA, Chicago, etc.)
- Bug reports and suggestions via Issues

---

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.

---

## 🙏 Acknowledgments

- Rules based on the *APA Publication Manual, 7th Edition* (American Psychological Association, 2019)
- Chinese APA rules follow 《心理学报》投稿指南 (Acta Psychologica Sinica)
- Built for the [WorkBuddy](https://www.codebuddy.cn/) skill ecosystem
