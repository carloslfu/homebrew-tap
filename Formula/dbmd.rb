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
# per release tag, substituting 0.13.5 + the per-target sha256 values from
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
  version "0.13.5"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.13.5".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.13.5-darwin-aarch64.tar.gz"
      sha256 "261d444071028a6f6c1e7ab0c9afa19cd0413b846943c3eeabd458ae8f9402a4"
    end
    on_intel do
      url "#{BASE}/dbmd-0.13.5-darwin-x86_64.tar.gz"
      sha256 "2dc3a1645a75fe5747cd0b691fd029cdf81c84bb04f54a7457c628c262a263f8"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.13.5-linux-aarch64-musl.tar.gz"
      sha256 "49e391ca561ec2867448f0b32ab3091fc7f450e69705da6b07516488b25fa2ae"
    end
    on_intel do
      url "#{BASE}/dbmd-0.13.5-linux-x86_64-musl.tar.gz"
      sha256 "253bde0b3d4b4e85351fc91f2ac667b7e500ab80b30740cc0e9300b7723f86ad"
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
