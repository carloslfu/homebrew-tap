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
# per release tag, substituting 0.8.19 + the per-target sha256 values from
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
  version "0.8.19"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.19".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.19-darwin-aarch64.tar.gz"
      sha256 "2d5f9f05f58482df8f32404b240d98c5be27a39af8fd31a5af3b387c02b4f506"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.19-darwin-x86_64.tar.gz"
      sha256 "c6904180dc7b0a8bd4179386f53550f201a3301660c1eb28503fbbb2c9f19173"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.19-linux-aarch64-musl.tar.gz"
      sha256 "f4f0a1fb2ceba6540d1bfd539857c8a2e476268c2d7bc9cc02e9efdedbc8364e"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.19-linux-x86_64-musl.tar.gz"
      sha256 "7eeb523a311f273aa196f0e9315160e2039ecab3499101c510fd6ee7c1a13d2f"
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
