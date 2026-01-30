# Logi Optimizer Skill

This is an Agent-dedicated Skill designed to help macOS users remove bloated Logitech official software (G HUB, Logi Options+) and install a lightweight alternative.

## Features

- **Clean Purge**: Thoroughly remove Logitech official software and its residual files (supports G HUB and Options+).
- **Mini Install**: Install the community-maintained lightweight Logi Options+ Mini with support for custom feature modules (such as Flow, DFU, etc.).
- **Safe Mode**: All destructive operations (deletion, installation) provide `Dry Run` and confirmation steps by default.

## Installation

You can install this Skill in the following ways:

### Using npx
```bash
npx skill add kime541200/logi-optimizer-skill
```

### Manual Installation
Clone this repository to your Skill directory:
```bash
cd ~/.gemini/skills  # or your skill storage path
git clone https://github.com/kime541200/logi-optimizer-skill.git
```

## Usage

In Agent conversations, you can directly use natural language requests:

- "Help me clean up old Logitech software"
- "Install Logi Options+ Mini"

## System Requirements

- macOS
- Requires `sudo` privileges (for cleaning residual files and installation)

## Acknowledgments

This Skill encapsulates the functionality of [Qetesh/logi-options-plus-mini](https://github.com/Qetesh/logi-options-plus-mini).

---

**Language:** English | [繁體中文](README_zh.md)
