# typed: strict
# frozen_string_literal: true

# Homebrew formula for macluster.
class Macluster < Formula
  desc "Lightweight macOS cluster manager"
  homepage "https://github.com/FJingxian/macluster"
  url "https://github.com/FJingxian/macluster/releases/download/v0.1.8/macluster-v0.1.8-macos-arm64.tar.gz"
  sha256 "dd6eac9190b2922ae2bf441bb8753c6f96d2f2633a6ae94f82436d04160b33ee"

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
