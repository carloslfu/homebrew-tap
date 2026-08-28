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
# per release tag, substituting 0.8.39 + the per-target sha256 values from
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
  version "0.8.39"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.39".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.39-darwin-aarch64.tar.gz"
      sha256 "daecb9f6e59bbbea1bb783ce2d621b157774a5b56b40fa8325451184cabf2b22"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.39-darwin-x86_64.tar.gz"
      sha256 "a2af42f8ed773226f758fa186b5ad69488de01ba09ef206e0a028fab98aeed89"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.39-linux-aarch64-musl.tar.gz"
      sha256 "a78fb9de9b9876b42868c016fac647e20c263e253bbea674e35b0aedb4219ca7"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.39-linux-x86_64-musl.tar.gz"
      sha256 "5a68e3176de0f284b04dd2af821abb0b5227d408faa5108fea84326c000f486e"
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
