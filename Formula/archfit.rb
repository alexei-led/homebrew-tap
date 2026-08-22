class Archfit < Formula
  desc "Architecture-fitness checks for AI agents and CI"
  homepage "https://github.com/alexei-led/archfit"
  version "1.7.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-darwin-arm64"
      sha256 "aa116f9751b9d95d2e355380b97bf184d00079a133b2e6eb2e48963155b10bb1"
    else
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-darwin-amd64"
      sha256 "3729873117643fa0690e22260121d1a52e51ba697392259658d7ce1156129cd8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-linux-arm64"
      sha256 "162a723c41b52176ad1f2a5808b7ef410916a8b33e155a001178fdaf7bc29e01"
    else
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-linux-amd64"
      sha256 "d0c401d22480ae66eb83e5cbce0e48c44ad5903c56088decc28c0f8f293363a9"
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
