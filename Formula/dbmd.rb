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
# per release tag, substituting 0.10.0 + the per-target sha256 values from
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
  version "0.10.0"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.10.0".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.10.0-darwin-aarch64.tar.gz"
      sha256 "c087f57eb8ee3c727ef888d8275cd1ccb220b0d75895eab4f6e249b5cd31b17c"
    end
    on_intel do
      url "#{BASE}/dbmd-0.10.0-darwin-x86_64.tar.gz"
      sha256 "ab641d0e30bbd365e58eb6330f9803d266be0a8868006d568ba9b3114328496a"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.10.0-linux-aarch64-musl.tar.gz"
      sha256 "2ae788b2c45eb28d762922d670f89ed454ae7b8a5f1443cd38ebb0b4a7d46d1a"
    end
    on_intel do
      url "#{BASE}/dbmd-0.10.0-linux-x86_64-musl.tar.gz"
      sha256 "b1c46eaf493713499cd1b98a5fafebcd5a47b33c1b9ec3cb45b273daf4cdf457"
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
