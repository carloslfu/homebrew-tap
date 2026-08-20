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
# per release tag, substituting 0.8.16 + the per-target sha256 values from
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
  version "0.8.16"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.16".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.16-darwin-aarch64.tar.gz"
      sha256 "1d0821832fd0be8ff3ddd737a0d0ff1bada650170905a2355017e494d871f7a9"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.16-darwin-x86_64.tar.gz"
      sha256 "9dba91271f888909699d81cb9c7d41f25d9bc807bf102b503797c01744b03907"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.16-linux-aarch64-musl.tar.gz"
      sha256 "57621b292fd33b7380219b047c54a7e2288de0ee8c2b596248f141d5f4eea05b"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.16-linux-x86_64-musl.tar.gz"
      sha256 "d4953c6269c807ce418d02c378c3c585c64a943140e6466ffd00015a4ab10fa5"
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
