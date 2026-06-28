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
# per release tag, substituting 0.4.3 + the per-target sha256 values from
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
  version "0.4.3"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.4.3".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.4.3-darwin-aarch64.tar.gz"
      sha256 "82797e10a683522451bca5b62828d6236f24c72ec337d6cdd49b161f87c7d113"
    end
    on_intel do
      url "#{BASE}/dbmd-0.4.3-darwin-x86_64.tar.gz"
      sha256 "e5fd27d1da9ebf807cf7809790cc438abdceac28a17a9a9c4f5beb18f81e0b10"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.4.3-linux-aarch64-musl.tar.gz"
      sha256 "31615ff3e26c4dae2ee3730d35b691d6af58c5e58030a2570ec0c146f457bd57"
    end
    on_intel do
      url "#{BASE}/dbmd-0.4.3-linux-x86_64-musl.tar.gz"
      sha256 "0dc75172ac7ad24568e72cae4059ebe2db668533e82e9881d552c07b21acda35"
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
