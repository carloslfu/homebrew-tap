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
# per release tag, substituting 0.7.0 + the per-target sha256 values from
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
  version "0.7.0"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.7.0".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.7.0-darwin-aarch64.tar.gz"
      sha256 "344d3f30334ef7981210c883ac19ed87f794ec5d34bf304d1e0557ae9fbb2cd4"
    end
    on_intel do
      url "#{BASE}/dbmd-0.7.0-darwin-x86_64.tar.gz"
      sha256 "cfeb4941d742f80c3b5d23039359742cf6567c22d2b0cf775374f262cd834861"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.7.0-linux-aarch64-musl.tar.gz"
      sha256 "34dd3d395ceeacfcc85454607ead3a53eec85d7c5f002fc447138817c8423ff1"
    end
    on_intel do
      url "#{BASE}/dbmd-0.7.0-linux-x86_64-musl.tar.gz"
      sha256 "c6c0f8e49ba3460193ae64aad0d7ba64994f6c85052c77a3bc3ab0e99ec2e860"
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
