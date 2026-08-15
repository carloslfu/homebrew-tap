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
# per release tag, substituting 0.8.12 + the per-target sha256 values from
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
  version "0.8.12"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.12".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.12-darwin-aarch64.tar.gz"
      sha256 "29acc9090bb418bbbf9524aa602ebf15df7eb1d354176596a0d2f2083f99b037"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.12-darwin-x86_64.tar.gz"
      sha256 "074eb1066881a0b5565b4dd44d82564b01aca9ac38cec3e2112d1ce4bf8359b7"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.12-linux-aarch64-musl.tar.gz"
      sha256 "8b92a4e0b2281e4f8028f76e42f11b62f17b8611d9ebceb7253d6cc3bf98185a"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.12-linux-x86_64-musl.tar.gz"
      sha256 "751bc5fd1ce7cee58609363a7c478799e1b773d95683b3b29f165b6dee26b5e3"
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
