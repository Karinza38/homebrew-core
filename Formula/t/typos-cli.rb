class TyposCli < Formula
  desc "Source code spell checker"
  homepage "https://github.com/crate-ci/typos"
  url "https://github.com/crate-ci/typos/archive/refs/tags/v1.29.1.tar.gz"
  sha256 "f7f27bedf2c7cef988772095aff9178d601790736b9dcc4d9ecf7235d0ab88f4"
  license any_of: ["Apache-2.0", "MIT"]

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c0bdf97ca5551e28326f633dcd8e90c1122e9d6278dcb703fd0e83bd10fb7f4a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2899eff22111387931730917b9b63bc0f5fbe2cea9801c19d55119a85523db42"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "efa910dad29d83512f3598300bbabb0c3b5a01e7396ae53fc7e80a22c38949bc"
    sha256 cellar: :any_skip_relocation, sonoma:        "4e86adf5d55a5fee189df058d1fe3ebaa3fea01653f68f311b190323329b900d"
    sha256 cellar: :any_skip_relocation, ventura:       "d7b16a19517bdb0caeef684a1a0c38d1267103509b6c2a31d64046eb56fa17a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d8c00c2714b3a721a8b59b1bac04dd91217c6dc6d7354304500604ac7c48ff3d"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/typos-cli")
  end

  test do
    assert_match "error: `teh` should be `the`", pipe_output("#{bin}/typos -", "teh", 2)
    assert_empty pipe_output("#{bin}/typos -", "the")
  end
end
