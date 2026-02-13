class Spotinfo < Formula
  desc "CLI tool to explore AWS EC2 Spot instances with pricing and interruption analysis"
  homepage "https://github.com/alexei-led/spotinfo"
  version "2.2.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_darwin_arm64"
      sha256 "46689c8fc911836f823058e0f0bf71916a4e5addbf47b4ec2f6db7ce85e03b0c"
    else
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_darwin_amd64"
      sha256 "14d68c53e11c02b2271a2d3b0bb08ae69c00b1a6ec39ae31368fd90a1fbce947"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_linux_arm64"
      sha256 "436851e76c3d1941b87d84170a482ed2d996475ad9cb26e4481c6f0962b1375e"
    else
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_linux_amd64"
      sha256 "3f13e02d53a74afaa3a9de434e3f2d1ea2bdf06130049aefeed507ef276fc52d"
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
