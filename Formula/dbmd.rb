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
# per release tag, substituting 0.8.15 + the per-target sha256 values from
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
  version "0.8.15"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.15".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.15-darwin-aarch64.tar.gz"
      sha256 "64a60123e14c978dd88e89e2443cfaae1392337a4acf8ec8b48958c2cf79acc0"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.15-darwin-x86_64.tar.gz"
      sha256 "48f2f861f8629daf1142270983bd079f707a233dab62c7cce702b95179afecfc"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.15-linux-aarch64-musl.tar.gz"
      sha256 "fd36e5d02c71940bca5cb717a70cfa4d5ffd15c9e7f84afa8b10a504a7c00d9b"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.15-linux-x86_64-musl.tar.gz"
      sha256 "43c449a66e26194f094004df81f90082494d3ab43a18e00a73122b19dc8cb735"
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
