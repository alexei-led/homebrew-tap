class ClaudeProxy < Formula
  desc "Local native Anthropic API proxy for Claude Code"
  homepage "https://github.com/alexei-led/claude-proxy"
  # The tap updater requires an explicit version.
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_darwin_arm64"
      sha256 "ba77797cc6a71e417f83f63e2e8d0c67ee36de03c20cb77cbe40d5d46f1a8928"
    else
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_darwin_amd64"
      sha256 "0a03c691d0c75b2947c0661d7159a88e16b9b727b7e26c3883732bad45fac5c8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_linux_arm64"
      sha256 "11b92b37de0102b77258746a3eed4dab6b496d0877b0c23dac815133f76ea472"
    else
      url "https://github.com/alexei-led/claude-proxy/releases/download/v#{version}/claude-proxy_linux_amd64"
      sha256 "5f2cf3b9fba26f2e41db695d4805c2c325fd217b408d7244f81cc7af2d3750d1"
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
