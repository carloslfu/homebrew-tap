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
# per release tag, substituting 0.8.20 + the per-target sha256 values from
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
  version "0.8.20"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.20".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.20-darwin-aarch64.tar.gz"
      sha256 "9f98dd4540be6c861c98c5f455afa932461ea64381ec3fa66ecd41cb257372ac"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.20-darwin-x86_64.tar.gz"
      sha256 "65cb07c1cc088254fc703a7d265e6413c4b61b0bf4a042975da992aa5b83da9b"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.20-linux-aarch64-musl.tar.gz"
      sha256 "4b5ca1fa097649d28909981307288387e8a8ce22a949d5f875e8100a8d5640de"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.20-linux-x86_64-musl.tar.gz"
      sha256 "c43c078368c7bcc8e438d09574c745ce43d8a45b3a607281122e308b38c23814"
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
