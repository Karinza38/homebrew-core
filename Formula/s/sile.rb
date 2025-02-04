class Sile < Formula
  desc "Modern typesetting system inspired by TeX"
  homepage "https://sile-typesetter.org"
  license "MIT"

  stable do
    url "https://github.com/sile-typesetter/sile/releases/download/v0.15.8/sile-0.15.8.tar.zst"
    sha256 "64c17abafd5b1ef30419a81b000998870c1b081b6372d55bc31df9c3b83f0f6a"

    # Needed to workaround upstream source dist snafu, see configure phase
    on_macos do
      depends_on "autoconf" => :build
      depends_on "automake" => :build
      depends_on "libtool" => :build
    end
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "c73569b18ef58118933b042b2798cdfbf799a7d33db269233d277ebab9e65aae"
    sha256 cellar: :any,                 arm64_sonoma:  "6c9ccd73775633e380f73599b77b7743ab0cab761387f1b17b8a12077a54fdac"
    sha256 cellar: :any,                 arm64_ventura: "f9f0a55bebd34b16e5c20b741bec059de5a5833a425ee78095cf27b6a51e29a4"
    sha256 cellar: :any,                 sonoma:        "1399274b08181e6d034f66669f9f2c5e2cc26d201dd16502d7b55ec13e490ea3"
    sha256 cellar: :any,                 ventura:       "0af3edbdfbe446a79ed80f705ae432062390f9f42973779c9cba4cb0392bb308"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c5e0c9a04abe78f48723118e502326da42c8943a3ac54910569d3ce84b8f81e2"
  end

  head do
    url "https://github.com/sile-typesetter/sile.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "jq" => :build
  depends_on "pkgconf" => :build
  depends_on "poppler" => :build
  depends_on "rust" => :build

  depends_on "fontconfig"
  depends_on "harfbuzz"
  depends_on "icu4c@76"
  depends_on "libpng"
  depends_on "luajit"
  depends_on "luarocks"
  depends_on "openssl@3"

  uses_from_macos "unzip" => :build
  uses_from_macos "expat"
  uses_from_macos "zlib"

  on_macos do
    depends_on "freetype"
  end

  resource "compat53" do
    url "https://luarocks.org/manifests/lunarmodules/compat53-0.14.3-1.rockspec"
    sha256 "16218188112c20e9afa9e9057f753d29d7affb10fe3fb2ac74cab17c6de9a030"
  end

  resource "linenoise" do
    url "https://luarocks.org/manifests/hoelzro/linenoise-0.9-1.rockspec"
    sha256 "e4f942e0079092993832cf6e78a1f019dad5d8d659b9506692d718d0c0432c72"
  end

  resource "lpeg" do
    url "https://luarocks.org/manifests/gvvaughan/lpeg-1.1.0-1.src.rock"
    sha256 "6637fcf4d3ddef7be490a2f0155bd2dcd053272d1bb78c015498709ef9fa75dd"
  end

  resource "loadkit" do
    url "https://luarocks.org/manifests/leafo/loadkit-1.1.0-1.src.rock"
    sha256 "6a631cb08a78324cb5f92b1cb8e2f59502d7113407d0d9b0d95045d8a4febccb"
  end

  resource "lua_cliargs" do
    url "https://luarocks.org/manifests/lunarmodules/lua_cliargs-3.0.2-1.src.rock"
    sha256 "a2dfbd3f0236eaf4b0421dbd06a631d92b550335eb263b7283e1161a6e90d92e"
  end

  resource "lua-zlib" do
    url "https://luarocks.org/manifests/brimworks/lua-zlib-1.2-2.rockspec"
    sha256 "adc3e279ce67fb477ce7bf88cfb87607491d1c50d9c785b1567066c353f192f9"
  end

  # This resource cannot be updated
  # Ref: https://github.com/Homebrew/homebrew-core/pull/128136#issuecomment-1505583956
  resource "luaexpat" do
    url "https://luarocks.org/manifests/lunarmodules/luaexpat-1.4.1-1.src.rock"
    sha256 "b2b31f62fd09252d7ec0218d083cf9b8d9fc6a20f4594559f96649beee172233"
  end

  # depends on lpeg
  resource "luaepnf" do
    url "https://luarocks.org/manifests/siffiejoe/luaepnf-0.3-2.src.rock"
    sha256 "7abbe5888abfa183878751e4010239d799e0dfca6139b717f375c26292876f07"
  end

  resource "luafilesystem" do
    url "https://luarocks.org/manifests/hisham/luafilesystem-1.8.0-1.src.rock"
    sha256 "576270a55752894254c2cba0d49d73595d37ec4ea8a75e557fdae7aff80e19cf"
  end

  resource "luarepl" do
    url "https://luarocks.org/manifests/hoelzro/luarepl-0.10-1.rockspec"
    sha256 "a3a16e6e5e84eb60e2a5386d3212ab37c472cfe3110d75642de571a29da4ed8b"
  end

  resource "luasocket" do
    url "https://luarocks.org/manifests/lunarmodules/luasocket-3.1.0-1.src.rock"
    sha256 "f4a207f50a3f99ad65def8e29c54ac9aac668b216476f7fae3fae92413398ed2"
  end

  # depends on luasocket
  resource "luasec" do
    url "https://luarocks.org/manifests/brunoos/luasec-1.3.2-1.src.rock"
    sha256 "f93bf9927bd34a5d4f897f4488b285a12bee89c0e7d54b3b36dfcbf43a7ad4e5"
  end

  # depends on luafilesystem
  resource "penlight" do
    url "https://luarocks.org/manifests/tieske/penlight-1.14.0-2.src.rock"
    sha256 "f36affa14fb43e208a59f2e96d214f774b957bcd05d9c07ec52b39eac7f4a05d"
  end

  # depends on penlight
  resource "cldr" do
    url "https://luarocks.org/manifests/alerque/cldr-0.3.0-0.src.rock"
    sha256 "2efc94c10b659ab1009dc191f1694bd332c34379f87f4dd21f827d0e6948ed6d"
  end

  # depends on cldr, luaepnf, penlight
  resource "fluent" do
    url "https://luarocks.org/manifests/alerque/fluent-0.2.0-0.src.rock"
    sha256 "ea915c689dfce2a7ef5551eb3c09d4620bae60a51c20d48d85c14b69bf3f28ba"
  end

  # depends on luafilesystem, penlight
  resource "cassowary" do
    url "https://luarocks.org/manifests/simoncozens/cassowary-2.3.2-1.src.rock"
    sha256 "2d3c3954eeb8b5da1d7b1b56c209ed3ae11d221220967c159f543341917ce726"
  end

  resource "luautf8" do
    url "https://luarocks.org/manifests/xavier-wang/luautf8-0.1.5-2.src.rock"
    sha256 "68bd8e3c3e20f98fceb9e20d5a7a50168202c22eb45b87eff3247a0608f465ae"
  end

  resource "vstruct" do
    url "https://luarocks.org/manifests/deepakjois/vstruct-2.1.1-1.src.rock"
    sha256 "fcfa781a72b9372c37ee20a5863f98e07112a88efea08c8b15631e911bc2b441"
  end

  def install
    lua = Formula["luajit"]
    luaversion = "5.1"
    luapath = libexec/"vendor"

    paths = %W[
      #{luapath}/share/lua/#{luaversion}/?.lua
      #{luapath}/share/lua/#{luaversion}/?/init.lua
      #{luapath}/share/lua/#{luaversion}/lxp/?.lua
    ]

    ENV["LUA_PATH"] = "#{paths.join(";")};;"
    ENV["LUA_CPATH"] = "#{luapath}/lib/lua/#{luaversion}/?.so;;"

    ENV.prepend "CPPFLAGS", "-I#{lua.opt_include}/luajit-2.1"
    ENV.prepend "LDFLAGS", "-L#{lua.opt_lib}"

    if OS.mac?
      zlib_dir = expat_dir = "#{MacOS.sdk_path_if_needed}/usr"
    else
      zlib_dir = Formula["zlib"].opt_prefix
      expat_dir = Formula["expat"].opt_prefix
    end

    luarocks_args = %W[
      ZLIB_DIR=#{zlib_dir}
      EXPAT_DIR=#{expat_dir}
      OPENSSL_DIR=#{Formula["openssl@3"].opt_prefix}
      --tree=#{luapath}
      --lua-dir=#{lua.opt_prefix}
    ]

    resources.each do |r|
      r.stage do
        rock = Pathname.pwd.children(false).first
        unpack_dir = Utils.safe_popen_read("luarocks", "unpack", rock).split("\n")[-2]
        spec = "#{r.name}-#{r.version}.rockspec"
        cd unpack_dir do
          # Work around LuaJIT not exporting a setting for INT_MAX any
          # more and luautf8 expecting it transitively
          if r.name.eql? "luautf8"
            inreplace "lutf8lib.c", "#include <stdint.h>", "#include <stdint.h>\n#include <limits.h>"
          end
          system "luarocks", "make", *luarocks_args, spec
        end
      end
    end

    configure_args = %w[
      FCMATCH=true
      --disable-silent-rules
      --disable-static
      --disable-embeded-resources
      --with-system-lua-sources
      --with-system-luarocks
      --with-vendored-luarocks-dir=#{luapath}
    ]

    system "./bootstrap.sh" if build.head?
    system "./configure", *configure_args, *std_configure_args
    # Work around platform detection results having been baked into the
    # source dist (generated on Linux) with an extra configure cycle to
    # regenerate aminclude.m4 *after* having actually run the platform
    # detection on the target platform and found Darwin.
    if build.stable? && OS.mac?
      system "autoreconf", "-fiv"
      system "./configure", *configure_args, *std_configure_args
    end
    system "make"
    system "make", "install"
  end

  def caveats
    <<~EOS
      By default SILE uses the font Gentium Plus to render all documents that do not specifically call for something else. If this font is not available on your system you may encounter errors. Of lower priority depending on your use case, the math typesetting package defaults to using Libertinus Math and the default monospace font is Hack.

      Homebrew does not supply any of these font dependencies in default casks, but they can be added by tapping cask-fonts:
        brew tap homebrew/cask-fonts
        brew install --cask font-gentium-plus
        brew install --cask font-libertinus
        brew install --cask font-hack

      Alternatively you can download and install the fonts yourself:
        https://software.sil.org/gentium/
        https://github.com/alerque/libertinus
        https://sourcefoundry.org/hack/
    EOS
  end

  test do
    assert_match "SILE #{version.to_s.match(/\d\.\d\.\d/)}", shell_output("#{bin}/sile --version")
  end
end
