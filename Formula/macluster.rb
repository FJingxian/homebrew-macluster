# typed: strict
# frozen_string_literal: true

# Homebrew formula for macluster.
class Macluster < Formula
  desc "Lightweight macOS cluster manager"
  homepage "https://github.com/FJingxian/macluster"
  url "https://github.com/FJingxian/macluster/releases/download/v0.2.0/macluster-v0.2.0-macos-arm64.tar.gz"
  sha256 "6946790c6c98dff8f943fa4ff8b08fd9064e17fee7768817660f14b78a03eb53"

  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :monterey

  def install
    bin.install "macluster"
    aliases = %w[msub mjob mqueue mkill mtop mnode mfans]
    aliases.each do |name|
      bin.install_symlink bin/"macluster" => name
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/macluster --version")
    aliases = %w[msub mjob mqueue mkill mtop mnode mfans]
    aliases.each do |name|
      assert_predicate bin/name, :symlink?
    end
  end
end
