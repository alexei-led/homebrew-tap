class Ccbot < Formula
  include Language::Python::Virtualenv

  desc "Control Claude Code sessions remotely via Telegram"
  homepage "https://github.com/alexei-led/ccbot"
  url "https://files.pythonhosted.org/packages/source/c/ccbot/ccbot-VERSION.tar.gz"
  sha256 "SHA256_HASH"
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
