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
# per release tag, substituting 0.2.4 + the per-target sha256 values from
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

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.2.4".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.2.4-darwin-aarch64.tar.gz"
      sha256 "f9128a5f3b62d444615dc47d914f73eda643bf1aee74ed9beaa579f376d04527"
    end
    on_intel do
      url "#{BASE}/dbmd-0.2.4-darwin-x86_64.tar.gz"
      sha256 "6263312dde7afa6583b613c1a25e7ff05e38713784577c8f2d2d6cdbec904822"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.2.4-linux-aarch64-musl.tar.gz"
      sha256 "7aef594baed137d433e6c38daf0757b5100a7bc953519a1c95472fefc0dc573e"
    end
    on_intel do
      url "#{BASE}/dbmd-0.2.4-linux-x86_64-musl.tar.gz"
      sha256 "8cdc5e4294ef62c0e19779f0f2f78969c53ec841751dd75755a2e9bde206cb86"
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
