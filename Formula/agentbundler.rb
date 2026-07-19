class Agentbundler < Formula
  desc "Compile portable coding-agent assets into target-native packages"
  homepage "https://github.com/alexei-led/agentbundler"
  version "0.5.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_darwin_arm64"
      sha256 "04f22b7b58c7f8a18de561e430e9a1c20f372c05f247f92ceb5c23d7e6abb73e"
    else
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_darwin_amd64"
      sha256 "4c12f5b6731b448404e6c453e5bfc7825a8a4f56339666e74727b9288b38c5e0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_linux_arm64"
      sha256 "19446a492544114a6250bd3364593756977e2f44f9bf60a22ce9bd7f54387f13"
    else
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_linux_amd64"
      sha256 "90f8a9830e893cac789fc547a1af88032c01730a0c7ae1ec13bcada76ac7493a"
    end
  end

  def install
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "agentbundler_v#{version}_darwin_arm64" : "agentbundler_v#{version}_darwin_amd64"
    else
      Hardware::CPU.arm? ? "agentbundler_v#{version}_linux_arm64" : "agentbundler_v#{version}_linux_amd64"
    end

    bin.install binary_name => "agbun"
  end

  test do
    assert_match "agbun build", shell_output("#{bin}/agbun --help")
  end
end
