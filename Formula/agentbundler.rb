class Agentbundler < Formula
  desc "Compile portable coding-agent assets into target-native packages"
  homepage "https://github.com/alexei-led/agentbundler"
  version "0.4.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_darwin_arm64"
      sha256 "cc4cc417f73c8356db457eec84a2036dab31f4ff3ee97f052913068960a35f18"
    else
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_darwin_amd64"
      sha256 "3ecd3347c85039190fa30ffd89b9ef33aa90a2b72fe6642e834d9f75891b5094"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_linux_arm64"
      sha256 "ea8df5c38236431b6cdd15d231994fbba4153dde9e792e48894601a0d5f7f0ac"
    else
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_linux_amd64"
      sha256 "eec773b79f7b0f0f89eb7e0c903feb386ddd485e74cd814c8d50407f829f20cd"
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
