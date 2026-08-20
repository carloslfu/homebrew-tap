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
# per release tag, substituting 0.8.17 + the per-target sha256 values from
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
  version "0.8.17"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.17".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.17-darwin-aarch64.tar.gz"
      sha256 "17f4dfe9e07a9a40c5776f18b985e4fc45b5b0cc1fbc0895e6c91bb5fdedb5f7"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.17-darwin-x86_64.tar.gz"
      sha256 "52c01e28043ae66291ab32183defad021cd736d3dc985a18db60ba8b1c14b2f2"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.17-linux-aarch64-musl.tar.gz"
      sha256 "fbbc16ed900f1767077c3de4965eb4aacaf7f8b66df06f70dd5fdba3a72e5f52"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.17-linux-x86_64-musl.tar.gz"
      sha256 "5fb5b500a412e9985b23ed52defb67792f0cb61ea90c173d48b4c8bdcc2d6c56"
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
