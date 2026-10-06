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
# per release tag, substituting 0.14.4 + the per-target sha256 values from
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
  version "0.14.4"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.14.4".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.14.4-darwin-aarch64.tar.gz"
      sha256 "f794377ac892eedcd1b41a873541000f0bae407e5888dea9ed0f7f5cd4b47db9"
    end
    on_intel do
      url "#{BASE}/dbmd-0.14.4-darwin-x86_64.tar.gz"
      sha256 "11b9f09df6ce991ab616ccda12e6463cd056748888f3c5fdcaa13f7e63641ba3"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.14.4-linux-aarch64-musl.tar.gz"
      sha256 "15838791485699110cefc2e2470d8476f65d19943a1d8f3aac04015839070938"
    end
    on_intel do
      url "#{BASE}/dbmd-0.14.4-linux-x86_64-musl.tar.gz"
      sha256 "692750e8bccfd721f13abf146e90431c19c2dfe08b0cee860c0a89ffe6a0e4a5"
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
