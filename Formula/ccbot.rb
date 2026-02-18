class Ccbot < Formula
  include Language::Python::Virtualenv

  desc "Control Claude Code sessions remotely via Telegram"
  homepage "https://github.com/alexei-led/ccbot"
  url "https://files.pythonhosted.org/packages/c0/04/cb8d26c36514d697a6259b98228be71afb837c8f65338ca174860c9b61cd/ccbot-0.2.13.tar.gz"
  sha256 "237b8b23c38558825c888b4ead737d91fac0ebaf3942d8765f83ce2f8fbff801"
  license "MIT"

  depends_on "python@3.14"
  depends_on "tmux"

  resource "aiofiles" do
    url "https://files.pythonhosted.org/packages/41/c3/534eac40372d8ee36ef40df62ec129bee4fdb5ad9706e58a29be53b2c970/aiofiles-25.1.0.tar.gz"
    sha256 "a8d728f0a29de45dc521f18f07297428d56992a742f0cd2701ba86e44d23d5b2"
  end

  resource "anyio" do
    url "https://files.pythonhosted.org/packages/96/f0/5eb65b2bb0d09ac6776f2eb54adee6abe8228ea05b20a5ad0e4945de8aac/anyio-4.12.1.tar.gz"
    sha256 "41cfcc3a4c85d3f05c932da7c26d0201ac36f72abd4435ba90d0464a3ffed703"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/e0/2d/a891ca51311197f6ad14a7ef42e2399f36cf2f9bd44752b3dc4eab60fdc5/certifi-2026.1.4.tar.gz"
    sha256 "ac726dd470482006e014ad384921ed6438c457018f4b3d204aea4281258b2120"
  end

  resource "h11" do
    url "https://files.pythonhosted.org/packages/01/ee/02a2c011bdab74c6fb3c75474d40b3052059d95df7e73351460c8588d963/h11-0.16.0.tar.gz"
    sha256 "4e35b956cf45792e4caa5885e69fba00bdbc6ffafbfa020300e549b208ee5ff1"
  end

  resource "httpcore" do
    url "https://files.pythonhosted.org/packages/06/94/82699a10bca87a5556c9c59b5963f2d039dbd239f25bc2a63907a05a14cb/httpcore-1.0.9.tar.gz"
    sha256 "6e34463af53fd2ab5d807f399a9b45ea31c3dfa2276f15a2c3f00afff6e176e8"
  end

  resource "httpx" do
    url "https://files.pythonhosted.org/packages/b1/df/48c586a5fe32a0f01324ee087459e112ebb7224f646c0b5023f5e79e9956/httpx-0.28.1.tar.gz"
    sha256 "75e98c5f16b0f35b567856f597f06ff2270a374470a5c2392242528e3e3e42fc"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/6f/6d/0703ccc57f3a7233505399edb88de3cbd678da106337b9fcde432b65ed60/idna-3.11.tar.gz"
    sha256 "795dafcc9c04ed0c1fb032c2aa73654d8e8c5023a7df64a53f39190ada629902"
  end

  resource "libtmux" do
    url "https://files.pythonhosted.org/packages/e7/28/e2b252817cb181aec2f42fe2d1d7fac5ec9c4d15bfb2b8ea4bd1179e4244/libtmux-0.53.0.tar.gz"
    sha256 "1d19af4cea0c19543954d7e7317c7025c0739b029cccbe3b843212fae238f1bd"
  end

  resource "mistletoe" do
    url "https://files.pythonhosted.org/packages/11/96/ea46a376a7c4cd56955ecdfff0ea68de43996a4e6d1aee4599729453bd11/mistletoe-1.4.0.tar.gz"
    sha256 "1630f906e5e4bbe66fdeb4d29d277e2ea515d642bb18a9b49b136361a9818c9d"
  end

  resource "pillow" do
    url "https://files.pythonhosted.org/packages/1f/42/5c74462b4fd957fcd7b13b04fb3205ff8349236ea74c7c375766d6c82288/pillow-12.1.1.tar.gz"
    sha256 "9ad8fa5937ab05218e2b6a4cff30295ad35afd2f83ac592e68c0d871bb0fdbc4"
  end

  resource "python-dotenv" do
    url "https://files.pythonhosted.org/packages/f0/26/19cadc79a718c5edbec86fd4919a6b6d3f681039a2f6d66d14be94e75fb9/python_dotenv-1.2.1.tar.gz"
    sha256 "42667e897e16ab0d66954af0e60a9caa94f0fd4ecf3aaf6d2d260eec1aa36ad6"
  end

  resource "python-telegram-bot" do
    url "https://files.pythonhosted.org/packages/cd/9b/8df90c85404166a6631e857027866263adb27440d8af1dbeffbdc4f0166c/python_telegram_bot-22.6.tar.gz"
    sha256 "50ae8cc10f8dff01445628687951020721f37956966b92a91df4c1bf2d113742"
  end

  resource "telegramify-markdown" do
    url "https://files.pythonhosted.org/packages/33/eb/8a3a557eec87c0fcd4c0939232fa5ea407801050370596daa4ca3e51a1db/telegramify_markdown-0.5.4.tar.gz"
    sha256 "c32bd04e5a1c22519c011ccf7350a01b6d162e6cc9a9d89c83eff964d491007e"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ccbot --version")
  end
end
