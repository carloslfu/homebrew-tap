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
# per release tag, substituting 0.8.23 + the per-target sha256 values from
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
  version "0.8.23"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.23".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.23-darwin-aarch64.tar.gz"
      sha256 "f20c9a1a082299525ac77f2d47eaf523dd4e3120d5934e302463a429fc20a89a"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.23-darwin-x86_64.tar.gz"
      sha256 "c9d4baadd921519b268b6e05065af3ceb0d4c9d58f08f6cfe9782aa8f8bdc1e7"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.23-linux-aarch64-musl.tar.gz"
      sha256 "39c7104cb1eaed19cc9bae199b4ebacd21c22a6f7067d8a2b6ba4a2e2a042b7c"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.23-linux-x86_64-musl.tar.gz"
      sha256 "da677159fc6fdea09f40ec4ae9bb9280730a939bd803506e4ea5e0541a138b66"
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
