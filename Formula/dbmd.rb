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
# per release tag, substituting 0.8.37 + the per-target sha256 values from
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
  version "0.8.37"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.37".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.37-darwin-aarch64.tar.gz"
      sha256 "25bb6932b2d2fe3361300b16e6a1b832796cc4bf3996654818a5e4c1624178d2"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.37-darwin-x86_64.tar.gz"
      sha256 "f14340e0aca236c052ed29b40fb2c596ac741a689d2c9dfee31fc079b70018d5"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.37-linux-aarch64-musl.tar.gz"
      sha256 "7fd261c6543a99669144063488ccd5736f270efd431cec4ea25b9c09b687fa80"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.37-linux-x86_64-musl.tar.gz"
      sha256 "9c2f7877311ee31d4c0df9821fa252aac44d3a2d2f98d0242c857e00f8e2b7b4"
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
