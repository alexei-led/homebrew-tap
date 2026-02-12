class Ccbot < Formula
  include Language::Python::Virtualenv

  desc "Control Claude Code sessions remotely via Telegram"
  homepage "https://github.com/alexei-led/ccbot"
  url "https://github.com/alexei-led/ccbot/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "76c9beae0d451d60c635e451501a35a2998ec084a67d2bee4f8536777a256688"
  license "MIT"

  depends_on "python@3.14"
  depends_on "tmux"

  def install
    virtualenv_create(libexec, "python3.14")
    system libexec/"bin/pip", "install", *std_pip_args(build_isolation: true), "."
    bin.install_symlink Dir[libexec/"bin/ccbot"]
  end

  test do
    assert_match "usage", shell_output("#{bin}/ccbot --help", 2)
  end
end
