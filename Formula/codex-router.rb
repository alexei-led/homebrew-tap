class CodexRouter < Formula
  desc "Route Codex requests to a model and reasoning effort based on task complexity"
  homepage "https://github.com/alexei-led/codex-router"
  # The tap updater requires an explicit version, even though brew audit flags it as redundant.
  version "0.11.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-darwin-arm64"
      sha256 "211312d48ab6c5955ad95e090a4509400e6e6a70c8b25335d05d2e667c87da56"
    else
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-darwin-amd64"
      sha256 "7a1fa5d93a1230334876406f109828f2310823bf34346d75937877676eabc44f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-linux-arm64"
      sha256 "f3f5b10aeb44ceef354cbe63c35436c9d14151f840fbac89afedd885df9a17e5"
    else
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-linux-amd64"
      sha256 "3bdc81d0e980a64689728053eea2093ea473b79f5951d93d1d4ecf7958172dec"
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
