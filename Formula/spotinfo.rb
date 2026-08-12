class Spotinfo < Formula
  desc "Explore Spot instance prices, savings and interruption risk across AWS, GCP and Azure"
  homepage "https://github.com/alexei-led/spotinfo"
  version "2.5.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_darwin_arm64"
      sha256 "07fa9b510a845867894821fceb9afe6cb1349aaf53183627678d48af340513c3"
    else
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_darwin_amd64"
      sha256 "3d501c8fbfca0b69fbe9d91e29c7c3d913b1006454ca535cd67d826b7f0ed8b8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_linux_arm64"
      sha256 "ab539365fb659c2964e4f732435a0ef34258ff9ef288510ed907009db8f74d96"
    else
      url "https://github.com/alexei-led/spotinfo/releases/download/v#{version}/spotinfo_linux_amd64"
      sha256 "342e9fd32a157182a9d8999450e7c42dcfa8b1ec2ff3e0f7ffc725f44ece00e7"
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
