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
# per release tag, substituting 0.3.4 + the per-target sha256 values from
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
  version "0.3.4"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.3.4".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.3.4-darwin-aarch64.tar.gz"
      sha256 "e551d46bf969c53bf9125ec4edb48cc49749981f8a22bfc017a2335c8b46b463"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.4-darwin-x86_64.tar.gz"
      sha256 "a30b741329f248a45f60af8d690ebff89308797902707d84af9ef59ebe8b30ae"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.3.4-linux-aarch64-musl.tar.gz"
      sha256 "6dfc6ea5f8d709c53623e99bbf0164dd11c2a0acc4bd4aa5d9a2618225ac163b"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.4-linux-x86_64-musl.tar.gz"
      sha256 "923da57c290e1b0d10a0192ee3089f9514e3b49bac20088b7b384312de661a31"
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
