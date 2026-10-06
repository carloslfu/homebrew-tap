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
# per release tag, substituting 0.14.6 + the per-target sha256 values from
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
  version "0.14.6"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.14.6".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.14.6-darwin-aarch64.tar.gz"
      sha256 "9f0d753e613dc3b541576d31c4c1606693c1a147937dcb29d2ee94cb534cb824"
    end
    on_intel do
      url "#{BASE}/dbmd-0.14.6-darwin-x86_64.tar.gz"
      sha256 "e6ea5212d60051a07aea931b8bb8d8a3e0c8a93e819fc688490fe9bf6b32ce14"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.14.6-linux-aarch64-musl.tar.gz"
      sha256 "8f5c6c90164b62df989fc42afbd2b0f9de7414088aac00b4982fe436e46f2b6f"
    end
    on_intel do
      url "#{BASE}/dbmd-0.14.6-linux-x86_64-musl.tar.gz"
      sha256 "acc1a4f458dc2b83d967969792aa272e370211fd84cc1a03a7f58d17ca6e6df9"
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
