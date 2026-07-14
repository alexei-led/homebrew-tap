class Agentbundler < Formula
  desc "Compile portable coding-agent assets into target-native packages"
  homepage "https://github.com/alexei-led/agentbundler"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_darwin_arm64"
      sha256 "03bb62076faafe0db53e89bc5c4bf0009a1ac911409a27661ba38f643b484b03"
    else
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_darwin_amd64"
      sha256 "2c42beec79b7d41ec5571fef018fd02dd729a8d11594adda5e5db1f9529d871c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_linux_arm64"
      sha256 "a9488bb6c478bcdda80f8d09b5c27b59522f9b9d3460bad90a61b82ba0152e00"
    else
      url "https://github.com/alexei-led/agentbundler/releases/download/v#{version}/agentbundler_v#{version}_linux_amd64"
      sha256 "bb266a803dee6501893e6dc64cb96fb8ada389ce585172707d788ef1f90d6b96"
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
