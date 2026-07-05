class Archfit < Formula
  desc "Architecture-fitness checks for AI agents and CI"
  homepage "https://github.com/alexei-led/archfit"
  version "1.2.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-darwin-arm64"
      sha256 "2ae5e27ffdfd079a9f3830b88b8eef9795d83ec77ab79af9195a8b7355d586ff"
    else
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-darwin-amd64"
      sha256 "39ef62990fe56e193af2c796d6b837ac8a39eada7199337c200cb5f5981d824b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-linux-arm64"
      sha256 "20bbfc274e57c2e3943b0782f24740214229b995e019a8d345f800df59d5bf25"
    else
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-linux-amd64"
      sha256 "f4bffc78b742cef57dbf69889e3b616e060b5b57a0aafe0e35ff86309864fba9"
    end
  end

  def install
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "archfit-v#{version}-darwin-arm64" : "archfit-v#{version}-darwin-amd64"
    else
      Hardware::CPU.arm? ? "archfit-v#{version}-linux-arm64" : "archfit-v#{version}-linux-amd64"
    end

    bin.install binary_name => "archfit"
  end

  test do
    assert_match "archfit version", shell_output("#{bin}/archfit --version")
  end
end
