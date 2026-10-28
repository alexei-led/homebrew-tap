class CodexRouter < Formula
  desc "Route Codex requests to a model and reasoning effort based on task complexity"
  homepage "https://github.com/alexei-led/codex-router"
  # The tap updater requires an explicit version, even though brew audit flags it as redundant.
  version "0.11.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-darwin-arm64"
      sha256 "5d27461fe2abaf0c4dee4fba3b3ff808a236e80ffedcb975c22438ab8c791bee"
    else
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-darwin-amd64"
      sha256 "7227d37d12943c3ec27a46c8e14367e88f3fae2dcd7600fbdde934f5d3a62af8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-linux-arm64"
      sha256 "37b992c409a1affe677e296a330aa685bccbf1ded54fe425d618da079d962915"
    else
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-linux-amd64"
      sha256 "3a6070efc7e1a84b71feccdd00db96a3b6d5d1388ceac8e60d81bb6aab15779c"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "codex-router-#{os}-#{arch}" => "codex-router"
  end

  def caveats
    <<~EOS
      Codex CLI must be installed and signed in with ChatGPT.
      Homebrew does not configure Codex homes or start router services.

      If you previously ran codex-router setup, close that home's Codex
      sessions and rerun setup after each upgrade, preserving the original
      --home, --config, --state-dir options and environment. Setup records
      the executable path, which may point into a versioned Homebrew Cellar.

      Check the installed version and running endpoints with:
        codex-router version
        codex-router doctor
    EOS
  end

  test do
    assert_equal "v#{version}", shell_output("#{bin}/codex-router version").strip
  end
end
