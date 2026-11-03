class ClaudeProxy < Formula
  desc "Local native Anthropic API proxy for Claude Code"
  homepage "https://github.com/alexei-led/claude-proxy"
  # The tap updater requires an explicit version.
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_darwin_arm64"
      sha256 "815a0f91ec69f2864fbcf277a00ec51bcebaa2c77b65ff218524abbc01a35a5e"
    else
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_darwin_amd64"
      sha256 "9654cc09337bb9c386b3d1ae51ca1240e4ad24d5082dfd1f5dbed8f7627eb835"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_linux_arm64"
      sha256 "730e953c10dd2d1d1c0891f63f6ab5df23c73c8bb5e0bb57a7f6e9ea2bd2c0a9"
    else
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_linux_amd64"
      sha256 "d6b402eabe56da4ccad3a7fcd002866bfd97213532d6ddc8c718dc39216e1d44"
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
