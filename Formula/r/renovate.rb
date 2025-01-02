class Renovate < Formula
  desc "Automated dependency updates. Flexible so you don't need to be"
  homepage "https://github.com/renovatebot/renovate"
  url "https://registry.npmjs.org/renovate/-/renovate-39.88.0.tgz"
  sha256 "16684399076457e512db091dbd65d2a00cc929b4dbb1f0b5956ae8d542282bef"
  license "AGPL-3.0-only"

  # There are thousands of renovate releases on npm and the page the `Npm`
  # strategy checks is several MB in size and can time out before the request
  # resolves. This checks the first page of tags on GitHub (to minimize data
  # transfer).
  livecheck do
    url "https://github.com/renovatebot/renovate/tags"
    regex(%r{href=["']?[^"' >]*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
    strategy :page_match
    throttle 10
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e2a2b24aea9d7371b5c3ed32debac256d882eaf770e8c596ad7d8364870df01e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6caebdff4109d48043fb476b51f4e86ea42333c9d544ef5f1cfaaa61766cfcc7"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "475e4f575b2e05dff0ec9e3614691f2eed30a3ccd17539d57cc1afe860ef248d"
    sha256 cellar: :any_skip_relocation, sonoma:        "083dd682dfb61357d41d24c46fb0a6fb09a591c7d540b7a53b87536a6df46ebb"
    sha256 cellar: :any_skip_relocation, ventura:       "ed7fe55fd03b4c0b40ca242bfdf88b2744152d1e0797e65f5b8aff39ba88a629"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "85dd76dcfc9be7494ccf8f8bf2c20cdf3e5836afbd2027acb9a2a9240a763935"
  end

  depends_on "node@22"

  uses_from_macos "git", since: :monterey

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"renovate", "--platform=local", "--enabled=false"
  end
end
