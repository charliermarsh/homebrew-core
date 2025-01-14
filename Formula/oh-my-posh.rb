class OhMyPosh < Formula
  desc "Prompt theme engine for any shell"
  homepage "https://ohmyposh.dev"
  url "https://github.com/JanDeDobbeleer/oh-my-posh/archive/v12.19.0.tar.gz"
  sha256 "569e8e39792eea00be706cfd68b801b869499ed7f6c97c0c7067fe1472017c56"
  license "MIT"
  head "https://github.com/JanDeDobbeleer/oh-my-posh.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6b72b2da517b92cac36addee37df1071c9c0ab33c434f553b54abb42a1c26bd0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2df3fd2576fcac150b5d835c9f052546e4e5e5b10b87a44ee88d4dd44dc3c76d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "419c591ac15a41a27a1429c766c73c64b6d38ebe89a99dade40a4a39623b0f6c"
    sha256 cellar: :any_skip_relocation, monterey:       "cd4c37d4d89fdd8f5b141632763a71c837abd2a387a670c125821c28f56ffd51"
    sha256 cellar: :any_skip_relocation, big_sur:        "662a61bb160610aff6dca7725ba469ce755a6d099eea988418b787fc206d0a0c"
    sha256 cellar: :any_skip_relocation, catalina:       "dd817e271f1187ad1f0c541a2061a478cbf7fa9a0a1cdee8bca3967068cefdc6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dd1ca5ac8d87dadf269170bf441097ab572d31076774703f5bf484f936dbec8a"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.Version=#{version}
    ]
    cd "src" do
      system "go", "build", *std_go_args(ldflags: ldflags)
    end

    prefix.install "themes"
    pkgshare.install_symlink prefix/"themes"
  end

  test do
    assert_match "oh-my-posh", shell_output("#{bin}/oh-my-posh --init --shell bash")
  end
end
