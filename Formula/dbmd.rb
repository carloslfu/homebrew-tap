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
# per release tag, substituting 0.14.2 + the per-target sha256 values from
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
  version "0.14.2"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.14.2".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.14.2-darwin-aarch64.tar.gz"
      sha256 "b41425ca56e2ad43f8586d173213a7a4cdcf290b776d28afb6d472ab22e6614f"
    end
    on_intel do
      url "#{BASE}/dbmd-0.14.2-darwin-x86_64.tar.gz"
      sha256 "8c3ab37072cb57fea2283588547325e6fa464e3f1619667f83d5d6394568c833"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.14.2-linux-aarch64-musl.tar.gz"
      sha256 "2f2e3d1baf05cda4b2dd24ebe716c808498de406730f4a99d3bc8124be767bdc"
    end
    on_intel do
      url "#{BASE}/dbmd-0.14.2-linux-x86_64-musl.tar.gz"
      sha256 "f24403e5788aee3f6ee20826f6ae8e3d120f484d2e9788a4320256bf8dfc4193"
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
