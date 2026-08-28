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
# per release tag, substituting 0.9.0 + the per-target sha256 values from
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
  version "0.9.0"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.9.0".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.9.0-darwin-aarch64.tar.gz"
      sha256 "60a3361ad20a0940d632d2d498e45632b16d0e9e1d4d0f78cd092f86394801ff"
    end
    on_intel do
      url "#{BASE}/dbmd-0.9.0-darwin-x86_64.tar.gz"
      sha256 "980742613e91166efa2bb1043d71cc31d707e30455df857b9ad3dc1a72eb7c39"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.9.0-linux-aarch64-musl.tar.gz"
      sha256 "c34726fa063eda64102f6e7c7c393dd099ff8d2cf5b61bd7a9cafdf5139a0581"
    end
    on_intel do
      url "#{BASE}/dbmd-0.9.0-linux-x86_64-musl.tar.gz"
      sha256 "8df146cf14464dfc0f760d7aef1982e211ca701e847b192620198f134c77b10e"
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
