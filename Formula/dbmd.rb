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
# per release tag, substituting 0.8.1 + the per-target sha256 values from
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
  version "0.8.1"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.1".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.1-darwin-aarch64.tar.gz"
      sha256 "a32f2dcd680563182351a9196db57d84a52ffddf312147361808c40ed6b1231c"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.1-darwin-x86_64.tar.gz"
      sha256 "44cad41b57f98c8b5370c9a529a690cf4acae323e736802b3f85a6fb9bd6715a"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.1-linux-aarch64-musl.tar.gz"
      sha256 "04cf6650cc7e60b4d6978d7693925d4b366cc90e17e91459b47dfd7ae61da7ac"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.1-linux-x86_64-musl.tar.gz"
      sha256 "db48f41f4802f1ce559108bb3f3c332653fe4b4aafe26bd4404eb2f51fd11842"
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
