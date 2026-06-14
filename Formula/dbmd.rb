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
# per release tag, substituting 0.3.8 + the per-target sha256 values from
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
  version "0.3.8"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.3.8".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.3.8-darwin-aarch64.tar.gz"
      sha256 "ad9fabedc2c6913b81bb30293edddae874791d233eb928aed05484449277153c"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.8-darwin-x86_64.tar.gz"
      sha256 "5c92cfc86a7dd7c2126a186b9147493c78411a38978a115e85fe157e229671e0"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.3.8-linux-aarch64-musl.tar.gz"
      sha256 "a0b994c3c0a8099d78c808c8b0ab4bd5b366f31595ae955fc40dbb47e5cf59a0"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.8-linux-x86_64-musl.tar.gz"
      sha256 "8ac184e6f310bc55c0ff4e622ea409a3934edfa651a84792116e3f215da57ae9"
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
