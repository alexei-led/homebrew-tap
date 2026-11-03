class ClaudeProxy < Formula
  desc "Local native Anthropic API proxy for Claude Code"
  homepage "https://github.com/alexei-led/claude-proxy"
  # The tap updater requires an explicit version.
  version "0.1.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_darwin_arm64"
      sha256 "d258c16b395d8a4377dd064ee61a13022377a41ce86d6975a6a47ad55c58e504"
    else
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_darwin_amd64"
      sha256 "061f0087aac4c96bdf244a6548dfee4f6825e4b30e6372a9ae739a01ce5f90d8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_linux_arm64"
      sha256 "bee5a69e6f72b0183c10d4861cd096bb71c49554176e3b81beb7ef7063ab83c9"
    else
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_linux_amd64"
      sha256 "96ae82d889b6a22ce70ada778d9bb766c194ffa48658ca1999afe09b043049c3"
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

      Configure and start it manually:
        claude-proxy --config /path/to/personal.json --check
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
    assert_match "configuration valid",
                 shell_output("#{bin}/claude-proxy --config #{testpath}/config.json --check 2>&1")
    (testpath/"unsafe.json").write((testpath/"config.json").read.sub("127.0.0.1:43171", "0.0.0.0:43171"))
    assert_match "listener must be 127.0.0.1",
                 shell_output("#{bin}/claude-proxy --config #{testpath}/unsafe.json --check 2>&1", 1)
  end
end
