class Spotinfo < Formula
  desc "CLI tool to explore AWS EC2 Spot instances with pricing and interruption analysis"
  homepage "https://github.com/alexei-led/spotinfo"
  version "2.3.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_darwin_arm64"
      sha256 "a9f22b81fe0468f4d86a386bfc5a70890acdf3fdf4aa41d33e50d6f2f8d3650a"
    else
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_darwin_amd64"
      sha256 "1ae7ba58a561b4e3377dac6909bba33649bb6e3b3cb659307d241bd7517996ff"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_linux_arm64"
      sha256 "e0e9dac54e7dc026c0dd9e49b992fcfee1177c4aa182df800a52829fa41dd58e"
    else
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_linux_amd64"
      sha256 "a1317b2832e1a49970c72bb4e9c68e817e31f644072b3904cc2fb6708f049dc9"
    end
  end

  def install
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "spotinfo_darwin_arm64" : "spotinfo_darwin_amd64"
    else
      Hardware::CPU.arm? ? "spotinfo_linux_arm64" : "spotinfo_linux_amd64"
    end

    bin.install binary_name => "spotinfo"
  end

  test do
    assert_match "explore AWS EC2 Spot instances", shell_output("#{bin}/spotinfo --help")
    system bin/"spotinfo", "--version"
  end
end
