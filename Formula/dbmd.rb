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
# per release tag, substituting 0.6.4 + the per-target sha256 values from
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
  version "0.6.4"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.6.4".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.6.4-darwin-aarch64.tar.gz"
      sha256 "07482c8bdb0d6614c351e63c39074cd000a295f02fca18ac0f316d1d8bc7810c"
    end
    on_intel do
      url "#{BASE}/dbmd-0.6.4-darwin-x86_64.tar.gz"
      sha256 "30a91a6339ae4f2691c55cbb7d2aaaa5386a49c6c543eeb6d15bf6964fcd2280"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.6.4-linux-aarch64-musl.tar.gz"
      sha256 "679211d019bbb9539f2c5c33a574741a460b7dd40ed45890350112e2cbbbb2a6"
    end
    on_intel do
      url "#{BASE}/dbmd-0.6.4-linux-x86_64-musl.tar.gz"
      sha256 "840245b84445a3039a2b3e8aeb2cd6413d26b3f03d02c5d0626d3474ecc7438e"
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
