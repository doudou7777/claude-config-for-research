#!/usr/bin/env node
/**
 * PostToolUse Hook: Auto-format files with Prettier after Write/Edit
 *
 * Event: PostToolUse
 * Runs `npx prettier --write <file>` on supported file types.
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Prettier-supported extensions (built-in + common plugins)
const FORMATTABLE_EXTENSIONS = new Set([
  '.js', '.mjs', '.cjs',
  '.jsx',
  '.ts', '.mts', '.cts',
  '.tsx',
  '.json', '.json5', '.jsonc',
  '.css', '.scss', '.less',
  '.html', '.htm',
  '.md', '.mdx', '.markdown',
  '.yaml', '.yml',
  '.graphql', '.gql',
  '.vue', '.svelte', '.astro',
]);

// Read stdin input (PostToolUse passes tool context as JSON)
let input = {};
try {
  const stdinData = fs.readFileSync(0, 'utf8');
  if (stdinData.trim()) {
    input = JSON.parse(stdinData);
  }
} catch {
  process.exit(0);
}

const toolName = input.tool_name || '';
const toolInput = input.tool_input || {};
const filePath = toolInput.file_path || '';

// Only run for Write and Edit tools
if (toolName !== 'Write' && toolName !== 'Edit') {
  process.exit(0);
}

if (!filePath) {
  process.exit(0);
}

// Resolve to absolute path
const cwd = input.cwd || process.cwd();
const resolved = path.resolve(cwd, filePath);

// Check if file exists and extension is formattable
const ext = path.extname(resolved).toLowerCase();
if (!FORMATTABLE_EXTENSIONS.has(ext)) {
  process.exit(0);
}

if (!fs.existsSync(resolved)) {
  process.exit(0);
}

// Find project root for config resolution
function findProjectRoot(startDir) {
  let dir = path.dirname(path.resolve(startDir));
  const home = require('os').homedir();
  while (dir !== path.dirname(dir) && dir !== home) {
    const configFiles = ['.prettierrc', '.prettierrc.json', '.prettierrc.yaml', '.prettierrc.yml', '.prettierrc.js', '.prettierrc.mjs', '.prettierrc.cjs', 'prettier.config.js', 'prettier.config.mjs', 'prettier.config.cjs'];
    if (configFiles.some(f => fs.existsSync(path.join(dir, f)))) {
      return dir;
    }
    // Also check package.json for prettier config
    const pkgPath = path.join(dir, 'package.json');
    if (fs.existsSync(pkgPath)) {
      try {
        const pkg = JSON.parse(fs.readFileSync(pkgPath, 'utf8'));
        if (pkg.prettier) return dir;
      } catch {}
    }
    dir = path.dirname(dir);
  }
  return path.dirname(path.resolve(startDir));
}

try {
  const projectRoot = findProjectRoot(resolved);
  execSync(`npx prettier --write "${resolved}"`, {
    cwd: projectRoot,
    stdio: 'pipe',
    timeout: 10000,
  });
} catch {
  // Silently ignore formatting failures — don't block the user's workflow
}

process.exit(0);
