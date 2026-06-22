class Archfit < Formula
  desc "Architecture-fitness checks for AI agents and CI"
  homepage "https://github.com/alexei-led/archfit"
  version "0.7.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-darwin-arm64"
      sha256 "fa3079a914f65edd4f0f429baee02aafcbcfe2a63069bc45c99ec8ab7a503e75"
    else
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-darwin-amd64"
      sha256 "602d57ff1dfe495982b6b7f8e5b0cbe3693d94e92750587caf296112e05cba98"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-linux-arm64"
      sha256 "08d07381d281a9058da2e8389f94165d2ecd19834806a998a3450dbd999b9f25"
    else
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-linux-amd64"
      sha256 "92a8895b090c232cb283a60afae23b8903740071f4f65798c10385cb18a75a26"
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
