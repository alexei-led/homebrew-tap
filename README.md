# Homebrew Tap

Homebrew formulae for [alexei-led](https://github.com/alexei-led) projects.

## Installation

```bash
brew tap alexei-led/tap
```

## Available Formulae

| Formula                                            | Description                                                       | Install                                |
| -------------------------------------------------- | ----------------------------------------------------------------- | -------------------------------------- |
| [spotinfo](https://github.com/alexei-led/spotinfo) | AWS EC2 Spot instance explorer with pricing and interruption data | `brew install alexei-led/tap/spotinfo` |
| [ccgram](https://github.com/alexei-led/ccgram)     | Control Claude Code sessions remotely via Telegram                | `brew install alexei-led/tap/ccgram`   |
| [archfit](https://github.com/alexei-led/archfit)   | Architecture-fitness checks for AI agents and CI                  | `brew install alexei-led/tap/archfit`  |

## Quick Install

```bash
# spotinfo
brew install alexei-led/tap/spotinfo

# ccgram
brew install alexei-led/tap/ccgram

# archfit
brew install alexei-led/tap/archfit
```

## Updates

GitHub-release binary formulae are updated automatically when new releases are published. PyPI-backed formulae still need a manual formula update. To get the latest:

```bash
brew update
brew upgrade alexei-led/tap/<formula>
```

## Adding a New Formula

GitHub-release binary repos can trigger formula updates via `repository_dispatch`. The tap workflow expects a formula with an explicit `version` stanza and release `url` entries that interpolate `#{version}`:

```yaml
# In your release workflow:
- name: Update Homebrew formula
  uses: peter-evans/repository-dispatch@v3
  with:
    token: ${{ secrets.TAP_GITHUB_TOKEN }}
    repository: alexei-led/homebrew-tap
    event-type: update-formula
    client-payload: '{"formula": "your-formula", "version": "${{ github.ref_name }}", "repo": "alexei-led/your-formula"}'
```
