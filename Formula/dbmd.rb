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
# per release tag, substituting 0.8.31 + the per-target sha256 values from
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
  version "0.8.31"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.31".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.31-darwin-aarch64.tar.gz"
      sha256 "bb03ace076109413f356b1448b4e978924c79132b5b89416b86d2ccb0e6992a6"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.31-darwin-x86_64.tar.gz"
      sha256 "47783c63762445ef71a1bf231714ab90159cc07069c7fae6c692fcf84bfb375c"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.31-linux-aarch64-musl.tar.gz"
      sha256 "2e00648e7acfc09091e39617c3dde503132cdb822a150eb2d62dfec3614754ca"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.31-linux-x86_64-musl.tar.gz"
      sha256 "9cb129e0c9379b16c424d25ce3a837ade7dd0c6650017344528cb9a245ceb6bd"
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
