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
# per release tag, substituting 0.3.6 + the per-target sha256 values from
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
  version "0.3.6"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.3.6".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.3.6-darwin-aarch64.tar.gz"
      sha256 "8c9db68bb9f9d71e5027b28e21941dfb3971f9ab52f155cf47d703471eb2212e"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.6-darwin-x86_64.tar.gz"
      sha256 "5a47045529fbe4e79c5931231f1bb2c73d7aa97594b066f98a73083ef04ea2a2"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.3.6-linux-aarch64-musl.tar.gz"
      sha256 "e2996043490a4dd54d473ce030e2a33bb4c2ad25120e83db3bab39000a982b3b"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.6-linux-x86_64-musl.tar.gz"
      sha256 "7bacade0f5390a886c9ad4faf5181d6d6281484153eb4316172d00d9b052c6ce"
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
