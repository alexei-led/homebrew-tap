class Agentbundler < Formula
  desc "Compile portable coding-agent assets into target-native packages"
  homepage "https://github.com/alexei-led/agentbundler"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_darwin_arm64"
      sha256 "c5a5f6e8ddc73dfc313a78510173b63c8c0c52a52e11118f828a1b60ec311e7d"
    else
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_darwin_amd64"
      sha256 "e6fba2f52aff2d7c9de89d87f6f911dea767a40543093bb8b9d0992e09843a1f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_linux_arm64"
      sha256 "175c2ef9ea1059af8a74576c5abf16e3cc6fc7e7a4057b5cadad14237d63c519"
    else
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_linux_amd64"
      sha256 "28960791a366deadf13482dfaa21b0948d5af92af1315cd204a69360ae2a1c53"
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
