class CodexRouter < Formula
  desc "Route Codex requests to a model and reasoning effort based on task complexity"
  homepage "https://github.com/alexei-led/codex-router"
  # The tap updater requires an explicit version, even though brew audit flags it as redundant.
  version "0.12.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-darwin-arm64"
      sha256 "4744278ad6bb813bb666a59dcf598d818283b50fffc0050d3dacf5f9bba2a3a9"
    else
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-darwin-amd64"
      sha256 "60ac235a18d81542df0f39aa7c1c2042a5bd340b69d611ad3f3324d14e6606d3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-linux-arm64"
      sha256 "0d774b33fb35149641cbf19370d1f682113120c74ea3339b85020a235a4ff473"
    else
      url "https://github.com/alexei-led/codex-router/releases/download/v#{version}/codex-router-linux-amd64"
      sha256 "5105e77dcf9a605e4ad5e1f2d32a3dc50f34f05b2486c5bff58398aee466999d"
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
