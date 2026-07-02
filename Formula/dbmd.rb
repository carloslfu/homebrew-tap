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
# per release tag, substituting 0.6.0 + the per-target sha256 values from
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
  version "0.6.0"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.6.0".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.6.0-darwin-aarch64.tar.gz"
      sha256 "525450c8d2be824d4c133e46830f95d432d401e8b786eceb62c35c6d8cf678db"
    end
    on_intel do
      url "#{BASE}/dbmd-0.6.0-darwin-x86_64.tar.gz"
      sha256 "11bec00bd9d73372fe70e8e0d01b7822d8584162d97d3a4eaca9cf4facf00755"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.6.0-linux-aarch64-musl.tar.gz"
      sha256 "2a15957836bcdd964c19bb8e9f902245f2b2b25078758722d3996ec2458274b2"
    end
    on_intel do
      url "#{BASE}/dbmd-0.6.0-linux-x86_64-musl.tar.gz"
      sha256 "cfe8b1b7c86ca2964dff44f40d12fc97583f3d0d56dc60b2477c3b26f6255f99"
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
