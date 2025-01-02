class Jj < Formula
  desc "Git-compatible distributed version control system"
  homepage "https://github.com/martinvonz/jj"
  url "https://github.com/martinvonz/jj/archive/refs/tags/v0.25.0.tar.gz"
  sha256 "3a99528539e414a3373f24eb46a0f153d4e52f7035bb06df47bd317a19912ea3"
  license "Apache-2.0"
  head "https://github.com/martinvonz/jj.git", branch: "main"

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "8c68aa03f762d4a106fc6563a8b0242e2040ad74087ffc50ff94ee2a2ed6a633"
    sha256 cellar: :any,                 arm64_sonoma:  "519c631c8ad27a47c3653c25b00ecd110def5317dbfa2457dd15315261b9c38f"
    sha256 cellar: :any,                 arm64_ventura: "0dbd13711971e970d1a9befd404bd701d99bcf99d0142cddad25c32cf56e1de8"
    sha256 cellar: :any,                 sonoma:        "02cc225541c515ee51c5f7431b713f9ba37cf0fa393c83e6506348d98951f223"
    sha256 cellar: :any,                 ventura:       "8720c9399a33adf9422e202c2cdc703ec27447239c8d8eb2974885cf84793b09"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "64d9f213e77215f750b018a2ce6794eef610d692140b136e173186f8d83717c0"
  end

  depends_on "pkgconf" => :build
  depends_on "rust" => :build
  depends_on "libgit2"
  depends_on "openssl@3"
  uses_from_macos "zlib"

  def install
    ENV["LIBGIT2_NO_VENDOR"] = "1"

    system "cargo", "install", *std_cargo_args(path: "cli")

    generate_completions_from_executable(bin/"jj", shell_parameter_format: :clap)

    (man1/"jj.1").write Utils.safe_popen_read(bin/"jj", "util", "mangen")
  end

  def check_binary_linkage(binary, library)
    binary.dynamically_linked_libraries.any? do |dll|
      next false unless dll.start_with?(HOMEBREW_PREFIX.to_s)

      File.realpath(dll) == File.realpath(library)
    end
  end

  test do
    system bin/"jj", "init", "--git"
    assert_predicate testpath/".jj", :exist?

    [
      Formula["libgit2"].opt_lib/shared_library("libgit2"),
      Formula["openssl@3"].opt_lib/shared_library("libcrypto"),
      Formula["openssl@3"].opt_lib/shared_library("libssl"),
    ].each do |library|
      assert check_binary_linkage(bin/"jj", library),
             "No linkage with #{library.basename}! Cargo is likely using a vendored version."
    end
  end
end
