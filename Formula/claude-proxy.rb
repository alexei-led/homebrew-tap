class ClaudeProxy < Formula
  desc "Local native Anthropic API proxy for Claude Code"
  homepage "https://github.com/alexei-led/claude-proxy"
  # The tap updater requires an explicit version.
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_darwin_arm64"
      sha256 "dbbdbe3501b85bbd7bf47304d0e22a045fa92fa2c1bfde1882e7d82bbb12acea"
    else
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_darwin_amd64"
      sha256 "ef627dbbf75bd41e35866447c1646e67b387a8ef7170fc942c14abc7c6bf002b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_linux_arm64"
      sha256 "5ffbd16b214acceacef09a6d86554a48e1cb0bac81f881ece76c0e5831f83bed"
    else
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_linux_amd64"
      sha256 "624b4a6134314d33c9bc068807dbe63c7a0621d6044c6e90fa802cd870d6ca93"
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
