class ClaudeProxy < Formula
  desc "Local native Anthropic API proxy for Claude Code"
  homepage "https://github.com/alexei-led/claude-proxy"
  # The tap updater requires an explicit version.
  version "0.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_darwin_arm64"
      sha256 "d68e4f6e538c0f210608858caffecef13acc71ab6a3e35cc8c1b17a1ded8377f"
    else
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_darwin_amd64"
      sha256 "9bea76b105f9e5df3d366ef0cca583804d2bd93f2095e7803b181bc7b4bac6d4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_linux_arm64"
      sha256 "a319c4fa5c9af778344aefe059a14b85f411dd3173f3fa856fff44ca279269f7"
    else
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_linux_amd64"
      sha256 "d61d0318d33f43a4c16e0fea37ab4e99664028ee15074b6faa303b396b5dfabb"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "claude-proxy_#{os}_#{arch}" => "claude-proxy"
  end

  def caveats
    <<~EOS
      Experimental: review the tested client/provider combinations before use.
      Homebrew installs only the binary. It does not create configuration,
      read credentials, install a service, or start the proxy.

      Configure and launch on demand:
        claude-proxy --config /path/to/personal.json --check
        claude-proxy run --config /path/to/personal.json -- claude

      For a manual foreground server (no auto-close):
        claude-proxy --config /path/to/personal.json

      Guide: https://github.com/alexei-led/claude-proxy/blob/main/docs/integration.md
    EOS
  end

  test do
    (testpath/"access.key").write("dummy-brew-access\n")
    chmod 0600, testpath/"access.key"
    (testpath/"config.json").write <<~JSON
      {
        "version": 1,
        "profile": "personal",
        "listen": "127.0.0.1:43171",
        "access_token_file": "access.key",
        "upstreams": {
          "local": {
            "messages_url": "http://127.0.0.1:1/v1/messages",
            "auth": { "mode": "none" }
          }
        },
        "models": { "brew-test": { "upstream": "local" } }
      }
    JSON
    assert_match(/VALID\s+personal\s*\z/,
                 shell_output("#{bin}/claude-proxy --config #{testpath}/config.json --check 2>&1"))
    (testpath/"unsafe.json").write((testpath/"config.json").read.sub("127.0.0.1:43171", "0.0.0.0:43171"))
    assert_match "listener must be 127.0.0.1",
                 shell_output("#{bin}/claude-proxy --config #{testpath}/unsafe.json --check 2>&1", 1)
  end
end
