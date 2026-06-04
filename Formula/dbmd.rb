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
# per release tag, substituting 0.3.3 + the per-target sha256 values from
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
  version "0.3.3"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.3.3".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.3.3-darwin-aarch64.tar.gz"
      sha256 "560173cdd996f8d503c6f186c48fea145ee681350aea8a540d8077a592d7211e"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.3-darwin-x86_64.tar.gz"
      sha256 "a56fba41768726356b9204f54aa75072214a00f597e95f8922e65cde1204282a"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.3.3-linux-aarch64-musl.tar.gz"
      sha256 "83c58cc1338020cc333561750273a94b9075efae25d53495f63913009fbc1fee"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.3-linux-x86_64-musl.tar.gz"
      sha256 "f137e479ecd2792ebe289c79891ace4fb41d35287ba1b38481b97f21fdb618f9"
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
