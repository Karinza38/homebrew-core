class GolangciLint < Formula
  desc "Fast linters runner for Go"
  homepage "https://golangci-lint.run/"
  url "https://github.com/golangci/golangci-lint.git",
        tag:      "v1.63.2",
        revision: "15412b30790ad2d5505862cb1f55b27761ca3505"
  license "GPL-3.0-only"
  head "https://github.com/golangci/golangci-lint.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3a3c749851e3cc168b046e2f69393102f7f0e454de7b334abd526ec983771576"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7b9633ff87a67a2bbc14d9c35b4e224e39931288dd7bf507a47d9205c1a8afd1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9cf3feab88f700e15f2c3d9df6e2e9ed53721006e7556d42d58188d783503b8c"
    sha256 cellar: :any_skip_relocation, sonoma:        "9b32963ba7f249ccba8c50a94d33cd83de1a51da774dbad83b887eb927cbc170"
    sha256 cellar: :any_skip_relocation, ventura:       "0b66a8e2812f503200eb5aaeda9d209ef3e4098aca55028e868517c8f920a0c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f3f85ca50f28801de05474e616564115b78689a102e821b2352a047d7c8ef949"
  end

  depends_on "go"

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version}
      -X main.commit=#{Utils.git_short_head(length: 7)}
      -X main.date=#{time.iso8601}
    ]

    system "go", "build", *std_go_args(ldflags:), "./cmd/golangci-lint"

    generate_completions_from_executable(bin/"golangci-lint", "completion")
  end

  test do
    str_version = shell_output("#{bin}/golangci-lint --version")
    assert_match(/golangci-lint has version #{version} built with go(.*) from/, str_version)

    str_help = shell_output("#{bin}/golangci-lint --help")
    str_default = shell_output(bin/"golangci-lint")
    assert_equal str_default, str_help
    assert_match "Usage:", str_help
    assert_match "Available Commands:", str_help

    (testpath/"try.go").write <<~GO
      package try

      func add(nums ...int) (res int) {
        for _, n := range nums {
          res += n
        }
        clear(nums)
        return
      }
    GO

    args = %w[
      --color=never
      --disable-all
      --issues-exit-code=0
      --print-issued-lines=false
      --enable=unused
    ].join(" ")

    ok_test = shell_output("#{bin}/golangci-lint run #{args} #{testpath}/try.go")
    expected_message = "try.go:3:6: func `add` is unused (unused)"
    assert_match expected_message, ok_test
  end
end
