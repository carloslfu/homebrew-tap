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
# per release tag, substituting 0.6.5 + the per-target sha256 values from
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
  version "0.6.5"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.6.5".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.6.5-darwin-aarch64.tar.gz"
      sha256 "8b0e39145a8560a59af4b83d5a52fa4e541257c153f546b806a4ea76a1d6e9ac"
    end
    on_intel do
      url "#{BASE}/dbmd-0.6.5-darwin-x86_64.tar.gz"
      sha256 "868bc00014ae6acbfa616e28a229985f4745c987c39a45033e5cad083cd5aba4"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.6.5-linux-aarch64-musl.tar.gz"
      sha256 "926d701e2560ff8942e21b8fae26f25cd02677c4fede31781a703981f5bec5db"
    end
    on_intel do
      url "#{BASE}/dbmd-0.6.5-linux-x86_64-musl.tar.gz"
      sha256 "da9016f0345e1ab0cadaac29653e59065b1f9a4620ba375665c6b4cc6d78a9e6"
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
