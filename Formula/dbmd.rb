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
# per release tag, substituting 0.8.36 + the per-target sha256 values from
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
  version "0.8.36"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.36".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.36-darwin-aarch64.tar.gz"
      sha256 "9de2f88c45dce9dda78e41075c644271eadbc7e6727b67f9e0f11bd4b408cf93"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.36-darwin-x86_64.tar.gz"
      sha256 "ce1877423e7d92da23407acf2dafec5b15f94357f21a2c7b5db5d7d24587948c"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.36-linux-aarch64-musl.tar.gz"
      sha256 "602ef19e9c3f7dd24c92b622e70034f6eae8655fdf632ba6e05c9ea50f9ead73"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.36-linux-x86_64-musl.tar.gz"
      sha256 "563865bb1cb81a8de6595c23e3fcd42c9a0c6ce2904cde06f0c156aeef075a0c"
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
