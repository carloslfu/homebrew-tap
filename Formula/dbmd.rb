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
# per release tag, substituting 0.8.33 + the per-target sha256 values from
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
  version "0.8.33"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.33".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.33-darwin-aarch64.tar.gz"
      sha256 "5df84266754b413891eb9a4e1cdc43dd15356190470efe3f58707723e07a95f0"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.33-darwin-x86_64.tar.gz"
      sha256 "c205746808ec956593c8e4c34e66239855b2d073cdf5cf77c7893129bb2a8eb2"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.33-linux-aarch64-musl.tar.gz"
      sha256 "4d18636a1cdb137dd8d618a264d8da28165dbdac7b21e7f9311fad213112c84f"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.33-linux-x86_64-musl.tar.gz"
      sha256 "f681c4d9f831e6309806e4041d8e4a37eb5a4f197b82f25aa2d5664518eb398e"
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
