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
# per release tag, substituting 0.3.7 + the per-target sha256 values from
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
  version "0.3.7"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.3.7".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.3.7-darwin-aarch64.tar.gz"
      sha256 "79d9571e7d2e9a139288c397dcd2c866bd004736cec2b2d5aee5c248f68d2f47"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.7-darwin-x86_64.tar.gz"
      sha256 "d27bde979bbacc6e3db8e6439d17f6f9adcd90d678b4de76107ce4ae824391c3"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.3.7-linux-aarch64-musl.tar.gz"
      sha256 "5a3c6117ffeda25a630c48aec482561adf88ca0c60ccbd6325c548fca7e27605"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.7-linux-x86_64-musl.tar.gz"
      sha256 "6369437e7bade61ac741a8f49956a92e4a3790f8e20059330442eed0a3fc977c"
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
