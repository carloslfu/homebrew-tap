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
# per release tag, substituting 0.8.18 + the per-target sha256 values from
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
  version "0.8.18"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.18".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.18-darwin-aarch64.tar.gz"
      sha256 "5a82533fcd72190f252875a33c9978ffcba02ef7f4cd57d0bd63110686b62f84"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.18-darwin-x86_64.tar.gz"
      sha256 "4ce50c35e478a7932cc68afa488b7fa011c6ecdf79a29eb304838c962fb3198a"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.18-linux-aarch64-musl.tar.gz"
      sha256 "291e638bdc7364c983b6adb0722bc93d98713c8d8064fbdc03352cdbd46025fa"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.18-linux-x86_64-musl.tar.gz"
      sha256 "97dc39659ba48ab74c9a49daa438392392d94e9ab77eb1e4f057ae9bc6cd3592"
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
