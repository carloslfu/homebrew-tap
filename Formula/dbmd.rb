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
# per release tag, substituting 0.7.2 + the per-target sha256 values from
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
  version "0.7.2"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.7.2".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.7.2-darwin-aarch64.tar.gz"
      sha256 "2b51ded0abb30a3421d6646056ae7ce31a9252ad4164be1b9381fd7a7f28e7fa"
    end
    on_intel do
      url "#{BASE}/dbmd-0.7.2-darwin-x86_64.tar.gz"
      sha256 "9f6c036ac86fb156165c780b912f8cd04bbba635eff3ff629d6e21852468e29e"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.7.2-linux-aarch64-musl.tar.gz"
      sha256 "da8425863446126749d692dc04b686130bd437ee13a3075fc43d2e4775874917"
    end
    on_intel do
      url "#{BASE}/dbmd-0.7.2-linux-x86_64-musl.tar.gz"
      sha256 "45d738f7229fec97b37977f3269acd226628e3de42b74bcb4bce62ea85df5756"
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
