class Eza < Formula
  desc "Modern, maintained replacement for ls"
  homepage "https://github.com/eza-community/eza"
  url "https://github.com/eza-community/eza/archive/refs/tags/v0.20.15.tar.gz"
  sha256 "cbb50e61b35b06ccf487ee6cc88d3b624931093546194dd5a2bbd509ed1786d6"
  license "EUPL-1.2"

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "aca30e289b5e4767e2b184d604cffee30a35cc188251a8e1cba556d5de1d176d"
    sha256 cellar: :any,                 arm64_sonoma:  "da63d58bcecfac0a59d96293e8115595b911222a6418cdb482cee323eabb8018"
    sha256 cellar: :any,                 arm64_ventura: "e5817ba8f9b526a8dc3927dd8c1e4aad5a33403380627152913604974e79dfd9"
    sha256 cellar: :any,                 sonoma:        "51578152b673c356cd6e39e518e70600ec8d99ebd99f27fbced046038757f027"
    sha256 cellar: :any,                 ventura:       "9bfac7b56dc6317ad4ef2c5f21605f9b7e58bc9fc8c0054f441e4c23a305f56c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a27629f3769e6ece17c5daa4ffc148e45d7532e7a289bb6fcc0f66008ce76389"
  end

  depends_on "pandoc" => :build
  depends_on "pkgconf" => :build
  depends_on "rust" => :build
  depends_on "libgit2"

  def install
    ENV["LIBGIT2_NO_VENDOR"] = "1"

    system "cargo", "install", *std_cargo_args

    bash_completion.install "completions/bash/eza"
    fish_completion.install "completions/fish/eza.fish"
    zsh_completion.install  "completions/zsh/_eza"

    args = %w[
      --standalone
      --from=markdown
      --to=man
    ]
    system "pandoc", *args, "man/eza.1.md", "-o", "eza.1"
    system "pandoc", *args, "man/eza_colors.5.md", "-o", "eza_colors.5"
    system "pandoc", *args, "man/eza_colors-explanation.5.md", "-o", "eza_colors-explanation.5"

    man1.install buildpath.glob("*.1")
    man5.install buildpath.glob("*.5")
  end

  test do
    testfile = "test.txt"
    touch testfile
    assert_match testfile, shell_output(bin/"eza")

    # Test git integration
    flags = "--long --git --no-permissions --no-filesize --no-user --no-time --color=never"
    eza_output = proc { shell_output("#{bin}/eza #{flags}").lines.grep(/#{testfile}/).first.split.first }
    system "git", "init"
    assert_equal "-N", eza_output.call
    system "git", "add", testfile
    assert_equal "N-", eza_output.call
    system "git", "commit", "-m", "Initial commit"
    assert_equal "--", eza_output.call

    linkage_with_libgit2 = (bin/"eza").dynamically_linked_libraries.any? do |dll|
      next false unless dll.start_with?(HOMEBREW_PREFIX.to_s)

      File.realpath(dll) == (Formula["libgit2"].opt_lib/shared_library("libgit2")).realpath.to_s
    end

    assert linkage_with_libgit2, "No linkage with libgit2! Cargo is likely using a vendored version."
  end
end
