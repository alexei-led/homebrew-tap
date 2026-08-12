class Spotinfo < Formula
  desc "Explore Spot instance prices, savings and interruption risk across AWS, GCP and Azure"
  homepage "https://github.com/alexei-led/spotinfo"
  version "3.0.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_darwin_arm64"
      sha256 "6c5279f16f00690eecf12a8edf108eb67855e9fa655906e54fa85e9fd2e7a50b"
    else
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_darwin_amd64"
      sha256 "d2d9abf654c3aa759e6654285c306d9fe11ac68d9bbd1fd855e61afc5f9d0cc7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_linux_arm64"
      sha256 "302b936a320340864c8b885f17f025a086ad45e9bbcd930472df71e015dba6c6"
    else
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_linux_amd64"
      sha256 "27cf1348fac8528c36794c68c70cf130b1039c96bff76b9074e394ef61969b21"
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
    help = shell_output("#{bin}/spotinfo --help")
    assert_match "list", help
    assert_match "recommend", help
    system bin/"spotinfo", "--version"

    # Answers from the embedded snapshot, so this needs no network and no
    # cloud credentials.
    assert_match "m5.large",
      shell_output("#{bin}/spotinfo list --cloud aws --offline --region us-east-1 " \
                   "--machine '^m5\\.large$' --output text")
  end
end
