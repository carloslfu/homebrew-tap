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
# per release tag, substituting 0.14.5 + the per-target sha256 values from
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
  version "0.14.5"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.14.5".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.14.5-darwin-aarch64.tar.gz"
      sha256 "0d365ef68040183b2c7b5d30754295cb94b448f675daa55e6bb05282c678a7c4"
    end
    on_intel do
      url "#{BASE}/dbmd-0.14.5-darwin-x86_64.tar.gz"
      sha256 "b759ea4f8f662983faf156a64d27d87133f805bdc423d37ba546c815cb7d0230"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.14.5-linux-aarch64-musl.tar.gz"
      sha256 "56d93bd034e16447791af42abc8712ef22f4026e2440e26e063f0fb6cc3d0f16"
    end
    on_intel do
      url "#{BASE}/dbmd-0.14.5-linux-x86_64-musl.tar.gz"
      sha256 "2b4ee0607c0b4e973cad415349721f3d9c8fc00a7f5cc633f8eadff335b7213a"
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
