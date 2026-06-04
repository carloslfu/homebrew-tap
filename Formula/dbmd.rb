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
# per release tag, substituting 0.3.2 + the per-target sha256 values from
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
  version "0.3.2"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.3.2".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.3.2-darwin-aarch64.tar.gz"
      sha256 "f3b08bcaa987e2bdc0ec1560b5f5119e0a8969a823b6f670958893bca5f1e056"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.2-darwin-x86_64.tar.gz"
      sha256 "2c8e21c2d1cc3c821cf7cba36ca06a92004bc7cfd5931f7cc4faaf3ba6c4eb2e"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.3.2-linux-aarch64-musl.tar.gz"
      sha256 "7d77d1ba7231207d974515ae2c014d6351407ab9f7bd8f948205dc44609b54a7"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.2-linux-x86_64-musl.tar.gz"
      sha256 "73dcf7ac7fd52ce0f694f158eacca4a94aa2d9a5442acbf78f279c4502c28cb4"
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
