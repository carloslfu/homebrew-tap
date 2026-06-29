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
# per release tag, substituting 0.4.6 + the per-target sha256 values from
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
  version "0.4.6"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.4.6".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.4.6-darwin-aarch64.tar.gz"
      sha256 "efd0ba2fa8b3599fac7325a532a6f622666b196573e40f8d38009d070d35fa14"
    end
    on_intel do
      url "#{BASE}/dbmd-0.4.6-darwin-x86_64.tar.gz"
      sha256 "2eaa0fd55704e653de43dbefb88f1c5ea436055a4361192000fc5bb76c189b95"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.4.6-linux-aarch64-musl.tar.gz"
      sha256 "12538fa95fe80eaaf3b71de4257caad0396ad774a67313388f0b2885aa1f10f6"
    end
    on_intel do
      url "#{BASE}/dbmd-0.4.6-linux-x86_64-musl.tar.gz"
      sha256 "c944fc52e6cb421e9db1bb03611e615555e92c13ec7902542b02a2e4e807b379"
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
