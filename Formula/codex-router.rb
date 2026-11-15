class CodexRouter < Formula
  desc "Route Codex requests to a model and reasoning effort based on task complexity"
  homepage "https://github.com/alexei-led/codex-router"
  # The tap updater requires an explicit version, even though brew audit flags it as redundant.
  version "0.13.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-darwin-arm64"
      sha256 "b9623d01f09c46671db37d7aeb21ca9ebb281b8ac2d33140300eb5cbd9735aba"
    else
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-darwin-amd64"
      sha256 "edb8c2326c1985e6f8ce60d88b7126f854d3158e27e2683c498380c59e99a295"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-linux-arm64"
      sha256 "4aae6c9d2f495c2b6ec958480ee4571b68e5f61e2a78bc3a709ebea5a25d34f3"
    else
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-linux-amd64"
      sha256 "099f7cd7443aae67734fcf027fae493e2acb3fe6e643cf96bd78f1ab8fb99553"
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
