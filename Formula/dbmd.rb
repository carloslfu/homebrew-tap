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
# per release tag, substituting 0.4.2 + the per-target sha256 values from
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
  version "0.4.2"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.4.2".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.4.2-darwin-aarch64.tar.gz"
      sha256 "551ede4e61a0625c56355f98909303d2d6f476a3e2df5cddf47c262fdd09ae37"
    end
    on_intel do
      url "#{BASE}/dbmd-0.4.2-darwin-x86_64.tar.gz"
      sha256 "086aa7c4e7fc23a88674fde4a7c5c1a9bdbe2496d032bf770d7a9d7edee782b3"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.4.2-linux-aarch64-musl.tar.gz"
      sha256 "bc82a06f6e730704fc0028ad722475e1e5f7c81d0854d39751313a01530240e7"
    end
    on_intel do
      url "#{BASE}/dbmd-0.4.2-linux-x86_64-musl.tar.gz"
      sha256 "b38be1567eac1915f6f2827d215f20775a6387b3c393c891968b8393bfe1d495"
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
