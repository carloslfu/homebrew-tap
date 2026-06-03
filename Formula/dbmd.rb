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
# per release tag, substituting 0.3.0 + the per-target sha256 values from
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
  version "0.3.0"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.3.0".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.3.0-darwin-aarch64.tar.gz"
      sha256 "8bfc6fa1d390237ed7d3ff92fe7648fae4e4ae5117571fda80568406251ed324"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.0-darwin-x86_64.tar.gz"
      sha256 "c06cf3bb52e668ca9dc9b2dedc14442bb44b05ec07f7d4b922ceeee9b959d43b"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.3.0-linux-aarch64-musl.tar.gz"
      sha256 "28f9f932c5cdbd1f777e9173ce21cf6e81be843174b68f96ca8d9932a78759d7"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.0-linux-x86_64-musl.tar.gz"
      sha256 "a7e2b5e62a736e1f00189ff2e989536716df45ab31e16d69815c6015807ecd0f"
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
