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
# per release tag, substituting 0.3.9 + the per-target sha256 values from
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
  version "0.3.9"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.3.9".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.3.9-darwin-aarch64.tar.gz"
      sha256 "e582511f376ddd85b3a5939a65e7b17f5715d21c87619a410b87696ca2737afa"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.9-darwin-x86_64.tar.gz"
      sha256 "a58f9aadb24f950e9645e8ad760ed2a0a1f4060735a79b59e45b474aca75e02a"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.3.9-linux-aarch64-musl.tar.gz"
      sha256 "52bf510e857a095c64e02372c5614f01623b93f161e3b581b4014b828a120ecc"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.9-linux-x86_64-musl.tar.gz"
      sha256 "91d89e96381ec527273b66bd3f4cc1f0b14505f34de223c53f1f5e1050e792d4"
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
