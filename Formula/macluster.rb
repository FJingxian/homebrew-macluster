# typed: strict
# frozen_string_literal: true

# Homebrew formula for macluster.
class Macluster < Formula
  desc "Lightweight macOS cluster manager"
  homepage "https://github.com/FJingxian/macluster"
  url "https://github.com/FJingxian/macluster/releases/download/v0.1.6/macluster-v0.1.6-macos-arm64.tar.gz"
  sha256 "d5ba045d97f038ab238af9285f84efe7a07b1792a2e21b52d23eab6727916a7c"

  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  def install
    bin.install "macluster"
    aliases = %w[msub mjob mqueue mkill mtop mnode mfans]
    aliases.each do |name|
      bin.install_symlink bin/"macluster" => name
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/macluster --version")
  end
end
