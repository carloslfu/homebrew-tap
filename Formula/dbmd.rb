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
# per release tag, substituting 0.6.2 + the per-target sha256 values from
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
  version "0.6.2"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.6.2".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.6.2-darwin-aarch64.tar.gz"
      sha256 "133eac2ddc2623d74f9aae96b277698148ff43a3d987e15ad89a89df80ccd5fa"
    end
    on_intel do
      url "#{BASE}/dbmd-0.6.2-darwin-x86_64.tar.gz"
      sha256 "7b593ba8e7811099ee15ba308e67e1f60c3b2addc4ff2e42a09d6647ce8166f4"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.6.2-linux-aarch64-musl.tar.gz"
      sha256 "187fbf6df57e25b3df2ae2898393fe02b8e29a5a50430e2f4e1c21f21a2de94b"
    end
    on_intel do
      url "#{BASE}/dbmd-0.6.2-linux-x86_64-musl.tar.gz"
      sha256 "5eb2c56217471c75baf80041fce16459165917595aa5ac53a6e3c05543fce8e1"
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
