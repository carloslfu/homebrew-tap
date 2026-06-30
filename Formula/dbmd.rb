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
# per release tag, substituting 0.5.0 + the per-target sha256 values from
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
  version "0.5.0"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.5.0".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.5.0-darwin-aarch64.tar.gz"
      sha256 "2e364709d63d63faaf8e8c02f9d6949c6111bca00db03be15334688277b1c897"
    end
    on_intel do
      url "#{BASE}/dbmd-0.5.0-darwin-x86_64.tar.gz"
      sha256 "efd3f3a7af9a6b23d781227cb2dc1c3a75e1a5d8c1128ef6eb75d01105d6eba0"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.5.0-linux-aarch64-musl.tar.gz"
      sha256 "e026e9760120ccb1a0525844216f3b4ea10acf1959f3e247ba4ccf23120fd0b8"
    end
    on_intel do
      url "#{BASE}/dbmd-0.5.0-linux-x86_64-musl.tar.gz"
      sha256 "b68cdc8ea1e237e3bf2199b94673b96642e9b3b06e4d510bf1a44c70c9a8a053"
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
