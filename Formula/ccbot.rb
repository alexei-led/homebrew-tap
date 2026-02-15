class Ccbot < Formula
  include Language::Python::Virtualenv

  desc "Control Claude Code sessions remotely via Telegram"
  homepage "https://github.com/alexei-led/ccbot"
  url "https://github.com/alexei-led/ccbot/archive/refs/tags/v0.2.8.tar.gz"
  sha256 "8a42aa410312d951fa6fb11e9654efa6d6da1355bc33a3abc8ca9dab7d89a890"
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
