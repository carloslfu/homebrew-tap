# SPDX-License-Identifier: Apache-2.0
#
# Homebrew formula template for the db.md CLI (the single `dbmd` binary).
#
# Published as part of the existing tap at
# https://github.com/carloslfu/homebrew-tap. To install:
#
#   brew install carloslfu/tap/dbmd
#
# The release pipeline (.github/workflows/release.yml) renders this template
# per release tag, substituting 0.2.3 + the per-target sha256 values from
# the release's SHA256SUMS manifest. Asset names match the release tarballs
# exactly: dbmd-<version>-<target>.tar.gz, downloaded from the GitHub Release on
# carloslfu/db.md. Each tarball stages the binary + NOTICE + THIRD_PARTY_NOTICES
# + LICENSE; the formula installs the `dbmd` binary and the legal files.
#
# Targets: darwin-x86_64, darwin-aarch64, linux-x86_64-musl, linux-aarch64-musl
# (Linux is the static musl build — runs on any distro).

class Dbmd < Formula
  desc "Command-line tool for db.md — the open database in plain files"
  homepage "https://github.com/carloslfu/db.md"
  license "Apache-2.0"
  version "0.2.3"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.2.3".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.2.3-darwin-aarch64.tar.gz"
      sha256 "82fe9237e2aea2c2baeb5c979b3319ca11eafc5272051e91f788ee70b04bba2a"
    end
    on_intel do
      url "#{BASE}/dbmd-0.2.3-darwin-x86_64.tar.gz"
      sha256 "86ec4e54600fb6229689de78d40f717fb616c93e217660e90489f2903b3bd327"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.2.3-linux-aarch64-musl.tar.gz"
      sha256 "814b2b880ea67117370ab5c58203e2adec876be2ed07c4bcbb1816061f57d113"
    end
    on_intel do
      url "#{BASE}/dbmd-0.2.3-linux-x86_64-musl.tar.gz"
      sha256 "cc3310938f4eab5eafcaa8189de601abc2f4c5a075a49b0b56a9d92512c292d7"
    end
  end

  def install
    bin.install "dbmd"
    # Ship the legal files alongside the binary (Apache-2.0 attribution).
    pkgshare.install "NOTICE", "THIRD_PARTY_NOTICES", "LICENSE"
  end

  test do
    assert_match "dbmd #{version}", shell_output("#{bin}/dbmd --version")
    assert_predicate bin/"dbmd", :exist?
  end
end
