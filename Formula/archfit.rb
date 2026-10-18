class Archfit < Formula
  desc "Architecture-fitness checks for AI agents and CI"
  homepage "https://github.com/alexei-led/archfit"
  version "3.0.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-darwin-arm64"
      sha256 "07f6fd989ffc5253493489cb370d3441e44f8ab5107a6e8c8422700cd6fb168e"
    else
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-darwin-amd64"
      sha256 "ba568da2611f7c0bc70c512c5247157ea0c2c5c592b0e5e0d246df7cccfc3dc9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-linux-arm64"
      sha256 "16a9ecbc69b96c6fad36f85166e406f90403f9328b033e4b08bf3709344d8b58"
    else
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-linux-amd64"
      sha256 "6cfefe7a0fd4c85591e37855a5d6efddf6c02b446ac17d538c47fe4133cbded3"
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
