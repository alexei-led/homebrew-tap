# Homebrew Tap

Homebrew formulae for [alexei-led](https://github.com/alexei-led) projects.

## Installation

```bash
brew tap alexei-led/tap
```

## Available Formulae

| Formula                                                    | Description                                                       | Install                                    |
| ---------------------------------------------------------- | ----------------------------------------------------------------- | ------------------------------------------ |
| [spotinfo](https://github.com/alexei-led/spotinfo)         | AWS EC2 Spot instance explorer with pricing and interruption data | `brew install alexei-led/tap/spotinfo`     |
| [ccgram](https://github.com/alexei-led/ccgram)             | Control Claude Code sessions remotely via Telegram                | `brew install alexei-led/tap/ccgram`       |
| [archfit](https://github.com/alexei-led/archfit)           | Architecture-fitness checks for AI agents and CI                  | `brew install alexei-led/tap/archfit`      |
| [agentbundler](https://github.com/alexei-led/agentbundler) | Compile portable coding-agent assets into target-native packages  | `brew install alexei-led/tap/agentbundler` |

## Quick Install

```bash
# spotinfo
brew install alexei-led/tap/spotinfo

# ccgram
brew install alexei-led/tap/ccgram

# archfit
brew install alexei-led/tap/archfit

# agentbundler
brew install alexei-led/tap/agentbundler
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
# In your release workflow. Keep TAP_GITHUB_TOKEN scoped to this tap.
- name: Update Homebrew formula
  env:
    TAP_GITHUB_TOKEN: ${{ secrets.TAP_GITHUB_TOKEN }}
    VERSION: ${{ github.ref_name }}
  run: |
    curl --fail-with-body --retry 3 --retry-all-errors \
      --request POST \
      --url 'https://api.github.com/repos/alexei-led/homebrew-tap/dispatches' \
      --header 'Accept: application/vnd.github+json' \
      --header "Authorization: Bearer $TAP_GITHUB_TOKEN" \
      --header 'X-GitHub-Api-Version: 2022-11-28' \
      --data "$(jq --null-input \
        --arg formula 'your-formula' \
        --arg version "${VERSION#v}" \
        --arg repo 'alexei-led/your-formula' \
        '{event_type: "update-formula", client_payload: {formula: $formula, version: $version, repo: $repo}}')"
```
