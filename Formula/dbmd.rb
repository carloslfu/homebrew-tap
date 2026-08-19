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
# per release tag, substituting 0.8.13 + the per-target sha256 values from
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
  version "0.8.13"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.13".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.13-darwin-aarch64.tar.gz"
      sha256 "e1078112521f51d936ceb82587c3669e22d9958486219a1ed742ddf9fd38affd"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.13-darwin-x86_64.tar.gz"
      sha256 "d4bccaf39b7c25036743dd4512316318ec4e5eb334cdfd07ac04495fcfbcbf13"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.13-linux-aarch64-musl.tar.gz"
      sha256 "376570714500b78363ec42963b6343d8bea36b56354060b2abe881f0f8c62d19"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.13-linux-x86_64-musl.tar.gz"
      sha256 "a942872f0e151f7753a7e71d6edc9bda0b855875848a0d1cd342b04873b7ee6c"
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
