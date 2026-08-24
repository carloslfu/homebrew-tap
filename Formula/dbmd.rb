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
# per release tag, substituting 0.8.27 + the per-target sha256 values from
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
  version "0.8.27"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.27".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.27-darwin-aarch64.tar.gz"
      sha256 "fafb619c8bc7c1296b164e89cd0d54dc90ee3f24f56efbcb48ec62b60272bd09"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.27-darwin-x86_64.tar.gz"
      sha256 "b9ed0a613b2a58838fef005e51cc0c3ad148e1e00f7ed4a6ba0dd7906b40c19a"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.27-linux-aarch64-musl.tar.gz"
      sha256 "012c90d9b104bf3ca4f6d3ec38eed5a8adeeaf518b674387ff2f079f001f29d3"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.27-linux-x86_64-musl.tar.gz"
      sha256 "eed79be9b733cc990306d4e68325847547eccfee9c99b17fedbfb7a655df79bc"
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
