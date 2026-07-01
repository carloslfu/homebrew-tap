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
# per release tag, substituting 0.5.1 + the per-target sha256 values from
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
  version "0.5.1"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.5.1".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.5.1-darwin-aarch64.tar.gz"
      sha256 "f779810e077926bfb27a223d2325a4869f08e4c8a0f3a180ff40571c56b80090"
    end
    on_intel do
      url "#{BASE}/dbmd-0.5.1-darwin-x86_64.tar.gz"
      sha256 "c2f08fd3af8573b48fb9682eca842f2847ccbf916d212dcded7861309c764e45"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.5.1-linux-aarch64-musl.tar.gz"
      sha256 "cc4cc8d5758ff5e8bce85fd24ba846f5035085eef8e661aa72d7ceb8742a175b"
    end
    on_intel do
      url "#{BASE}/dbmd-0.5.1-linux-x86_64-musl.tar.gz"
      sha256 "91567b0d0246eca6afbe02f25b7664269f4e6fc6fcb3c29ab57a260086556ea9"
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
