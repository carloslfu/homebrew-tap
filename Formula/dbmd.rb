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
# per release tag, substituting 0.13.2 + the per-target sha256 values from
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
  version "0.13.2"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.13.2".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.13.2-darwin-aarch64.tar.gz"
      sha256 "b3d5d927771e619bd2f9cd18671878d0ccdd43e1c1c1e754f124528e9feb16e2"
    end
    on_intel do
      url "#{BASE}/dbmd-0.13.2-darwin-x86_64.tar.gz"
      sha256 "2d148d18f9db18347bf2c61f33b85d2431b279d6ac99e9dd90122ee3b5094b8b"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.13.2-linux-aarch64-musl.tar.gz"
      sha256 "4d47b3e0271e2c76866563caa460ef77a86b817702e3f04baadb0d21d0218f58"
    end
    on_intel do
      url "#{BASE}/dbmd-0.13.2-linux-x86_64-musl.tar.gz"
      sha256 "302edd14d8bd0aab28f42a359c5e3b5b1bb51b4b3294bb4a2788ad95ccc6acac"
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
