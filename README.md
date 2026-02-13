# Homebrew Tap

Homebrew formulae for [alexei-led](https://github.com/alexei-led) projects.

## Installation

```bash
brew tap alexei-led/tap
```

## Available Formulae

| Formula | Description | Install |
|---------|-------------|---------|
| [spotinfo](https://github.com/alexei-led/spotinfo) | AWS EC2 Spot instance explorer with pricing and interruption data | `brew install alexei-led/tap/spotinfo` |
| [ccbot](https://github.com/alexei-led/ccbot) | Control Claude Code sessions remotely via Telegram | `brew install alexei-led/tap/ccbot` |

## Quick Install

```bash
# spotinfo
brew install alexei-led/tap/spotinfo

# ccbot
brew install alexei-led/tap/ccbot
```

## Updates

Formulae are updated automatically when new releases are published. To get the latest:

```bash
brew update
brew upgrade alexei-led/tap/<formula>
```

## Adding a New Formula

Source repos can trigger formula updates via `repository_dispatch`:

```yaml
# In your release workflow:
- name: Update Homebrew formula
  uses: peter-evans/repository-dispatch@v3
  with:
    token: ${{ secrets.TAP_GITHUB_TOKEN }}
    repository: alexei-led/homebrew-tap
    event-type: formula-update
    client-payload: '{"formula": "your-formula", "version": "${{ github.ref_name }}"}'
```
