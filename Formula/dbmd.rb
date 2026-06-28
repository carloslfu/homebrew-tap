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
# per release tag, substituting 0.4.4 + the per-target sha256 values from
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
  version "0.4.4"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.4.4".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.4.4-darwin-aarch64.tar.gz"
      sha256 "c2d03f7df1de97be5f7751b1bea69f03c1db2df1520b7cccb9ded4d7ef79dbfd"
    end
    on_intel do
      url "#{BASE}/dbmd-0.4.4-darwin-x86_64.tar.gz"
      sha256 "9cf53df00c2fe5bf27e5175ec6b6330a08f65d2fb9dd5bbfec693e77b609b992"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.4.4-linux-aarch64-musl.tar.gz"
      sha256 "a6225a3292c3818c15aadb3588687b5b0d4394276d3149e743ee6bfa2c47c25c"
    end
    on_intel do
      url "#{BASE}/dbmd-0.4.4-linux-x86_64-musl.tar.gz"
      sha256 "f74acfb751996314ec024326a93571856b65b8c19f613753b8aa2bde68eb4295"
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
