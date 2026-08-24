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
# per release tag, substituting 0.8.25 + the per-target sha256 values from
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
  version "0.8.25"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.25".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.25-darwin-aarch64.tar.gz"
      sha256 "e248fc4582a78a5fa0cbad6dcf5a1ee354b98652ab8e969b53fe7044280c8f96"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.25-darwin-x86_64.tar.gz"
      sha256 "7b6b078b31d9c602a59cb7e54b69c433c71ba8667981875be08ac08932e3d20c"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.25-linux-aarch64-musl.tar.gz"
      sha256 "de210f105056c9310f95bb837007e81bd06cc89f4c9718d3e6763949d322d915"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.25-linux-x86_64-musl.tar.gz"
      sha256 "b8aff403dba317343d6dccd4cce2b04dc74c50960935d17fcf55a9b89ff8d529"
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
