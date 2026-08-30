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
# per release tag, substituting 0.13.1 + the per-target sha256 values from
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
  version "0.13.1"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.13.1".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.13.1-darwin-aarch64.tar.gz"
      sha256 "9c5aca5a874cbd9936e3a4d3c59b401d9b495cd1566483235e3beae7bb356806"
    end
    on_intel do
      url "#{BASE}/dbmd-0.13.1-darwin-x86_64.tar.gz"
      sha256 "0c112a2dfc76b64c937f747862316284a38b501382b22c1ff9758796f44635da"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.13.1-linux-aarch64-musl.tar.gz"
      sha256 "011754c50af80ca70006def18355c3e9f32b05dfe22f9674ec6f775280b57983"
    end
    on_intel do
      url "#{BASE}/dbmd-0.13.1-linux-x86_64-musl.tar.gz"
      sha256 "58994ef36f2ef21d3f1e041497f449aa4f969ba970a9ea116fcd99b6c89ab9d8"
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
