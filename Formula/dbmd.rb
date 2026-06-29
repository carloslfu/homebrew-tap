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
# per release tag, substituting 0.4.5 + the per-target sha256 values from
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
  version "0.4.5"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.4.5".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.4.5-darwin-aarch64.tar.gz"
      sha256 "7f72ea6ae54be32344a9026940625c8f7a79dbdece04c55b7f7f61a83674e5f8"
    end
    on_intel do
      url "#{BASE}/dbmd-0.4.5-darwin-x86_64.tar.gz"
      sha256 "1e01165504b710614b83c5c1d0bd9dddadfe66e475d9cb716c1711d6087f029e"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.4.5-linux-aarch64-musl.tar.gz"
      sha256 "e90b7459a89abe07702b7578c55cf2f9a94aceb833cfad73d0844e70ee82b117"
    end
    on_intel do
      url "#{BASE}/dbmd-0.4.5-linux-x86_64-musl.tar.gz"
      sha256 "44c303a84356b5e9206279c8ab9ec063a092299742813159090de22a8531c75c"
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
