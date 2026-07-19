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
# per release tag, substituting 0.7.1 + the per-target sha256 values from
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
  version "0.7.1"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.7.1".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.7.1-darwin-aarch64.tar.gz"
      sha256 "a76ec449bc280b23973acee21f1514b868dc08ec531618a595c32469f8373096"
    end
    on_intel do
      url "#{BASE}/dbmd-0.7.1-darwin-x86_64.tar.gz"
      sha256 "9374afcb39237f538a0ef34f02463686e34656243f6e621183c35fcf3412622b"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.7.1-linux-aarch64-musl.tar.gz"
      sha256 "15572673b81dabc5fdc2029e9119228d5f35ebec7592347d3c4ef3ac3a64afb1"
    end
    on_intel do
      url "#{BASE}/dbmd-0.7.1-linux-x86_64-musl.tar.gz"
      sha256 "329dc696a175b1d83287fb1ee147bd7f7f4949a23e31ad8a7e853037c054e90f"
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
