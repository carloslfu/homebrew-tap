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
# per release tag, substituting 0.4.0 + the per-target sha256 values from
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
  version "0.4.0"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.4.0".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.4.0-darwin-aarch64.tar.gz"
      sha256 "435b32a30dea4516f42edf290e2a806d805c9b4b922d308692813c42eaa122f0"
    end
    on_intel do
      url "#{BASE}/dbmd-0.4.0-darwin-x86_64.tar.gz"
      sha256 "43127b7b4ad4c2162a7e1b2e5e49d9831ad2b0a288b4be4db99f5cf12e755151"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.4.0-linux-aarch64-musl.tar.gz"
      sha256 "3278e0a7dd75aef0bd6833e26d79a30a20511716cc86c02b627f4f7989768e1e"
    end
    on_intel do
      url "#{BASE}/dbmd-0.4.0-linux-x86_64-musl.tar.gz"
      sha256 "6b421794c8608c00fdfc7470b05aaaefb48882f56b96ca790386670673202bed"
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
