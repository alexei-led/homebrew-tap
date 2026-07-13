class Agentbundler < Formula
  desc "Compile portable coding-agent assets into target-native packages"
  homepage "https://github.com/alexei-led/agentbundler"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_darwin_arm64"
      sha256 "b6c5b58de1162673182db68da5cc1b1b1c04dacab8660af12e8cc00c34c1fbba"
    else
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_darwin_amd64"
      sha256 "f3dc1c5d2506936d1b51c3eee957008e08900788d542ca1dfa58ff332e4fedfc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_linux_arm64"
      sha256 "9239e790f921e7ed668e709e53be838509d084f37de48a39b0bb863312dfc7ab"
    else
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_linux_amd64"
      sha256 "f79e2db3e9a9ae73a0b3c39f9df3669ca2edb1b23482ef8555d944494a372d6f"
    end
  end

  def install
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "agentbundler_v#{version}_darwin_arm64" : "agentbundler_v#{version}_darwin_amd64"
    else
      Hardware::CPU.arm? ? "agentbundler_v#{version}_linux_arm64" : "agentbundler_v#{version}_linux_amd64"
    end

    bin.install binary_name => "agentbundler"
  end

  test do
    assert_match "agentbundler build", shell_output("#{bin}/agentbundler --help")
  end
end
