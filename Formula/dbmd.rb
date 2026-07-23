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
# per release tag, substituting 0.8.0 + the per-target sha256 values from
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
  version "0.8.0"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.0".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.0-darwin-aarch64.tar.gz"
      sha256 "0615e27f5455289b865f942736fdd3c227d4245b9964c285eb4b7cc007533d13"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.0-darwin-x86_64.tar.gz"
      sha256 "31f31e6c80bb9bf3924b18f00f14b796f09be6d62d12b3cb63e1daf05ae28935"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.0-linux-aarch64-musl.tar.gz"
      sha256 "2cffd965b854d8e60e5013ac083b6e29844adc511dadd356e701a6e4c8c2bd54"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.0-linux-x86_64-musl.tar.gz"
      sha256 "41b2c33963921e1482125d55e534180ea4b56aab6fdc16354e3461cd1522a62a"
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
