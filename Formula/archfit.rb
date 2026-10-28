class Archfit < Formula
  desc "Architecture-fitness checks for AI agents and CI"
  homepage "https://github.com/alexei-led/archfit"
  version "3.4.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-darwin-arm64"
      sha256 "dded1035c0d6a82864b07793b7f512bba5e2cf358630dee57f006f65bd3a11ba"
    else
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-darwin-amd64"
      sha256 "20bc4ae0fb0940568809398d9f14c687c916f3da2702fc5eabbe6701da47ef81"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-linux-arm64"
      sha256 "e59cbd44e093081ea1bf96b08cb5afefb33de35dbf607fd5529f3ac021533d34"
    else
      url "https://github.com/alexei-led/archfit/releases/download/v#{version}/archfit-v#{version}-linux-amd64"
      sha256 "e5c6a73bf30ecb38abc47c52793376b1cca4cd6416888809cc8c7269b791176c"
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
