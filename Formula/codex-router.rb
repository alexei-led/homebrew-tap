class CodexRouter < Formula
  desc "Route Codex requests to a model and reasoning effort based on task complexity"
  homepage "https://github.com/alexei-led/codex-router"
  # The tap updater requires an explicit version, even though brew audit flags it as redundant.
  version "0.13.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-darwin-arm64"
      sha256 "7285d0e9d6dda7ccd9a147e6feef14ed021e8f122aa9505ab838d9e134eea1eb"
    else
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-darwin-amd64"
      sha256 "41bcbc14a5c9ac12861647a84a95da779d27654905eab8fcabaa9ba1b7a5066f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-linux-arm64"
      sha256 "d993c90033cd45a77fa4d3812b12661f986510cda05b9c2f051aafe4c70a306a"
    else
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-linux-amd64"
      sha256 "385d8e78fa6cfb5504d9d4408f94ee9960c7c0df912b35ebc376dadbbfb894a3"
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
