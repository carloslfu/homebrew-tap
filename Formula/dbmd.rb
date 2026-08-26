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
# per release tag, substituting 0.8.32 + the per-target sha256 values from
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
  version "0.8.32"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.32".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.32-darwin-aarch64.tar.gz"
      sha256 "bba005a7863144a059d0a3f656d5f4f62a07b69f854258cd045799470103b383"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.32-darwin-x86_64.tar.gz"
      sha256 "a805d4c4043ca6353fb6b3966cfcdff46dc53b4cb6ce01da09b797d916f19090"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.32-linux-aarch64-musl.tar.gz"
      sha256 "91c743a40dcbdbf109e392d69a20761d54e0c039c94a1fef64375362768957e1"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.32-linux-x86_64-musl.tar.gz"
      sha256 "b4c2b4696fb2cfd8e0da6900862974c368d8ee36e11c51f17238632e7f1652a8"
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
