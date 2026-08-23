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
# per release tag, substituting 0.8.22 + the per-target sha256 values from
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
  version "0.8.22"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.22".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.22-darwin-aarch64.tar.gz"
      sha256 "5da872a555e8bbce107999114985697b0a2712d98fe33be5650a75a2eaee7289"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.22-darwin-x86_64.tar.gz"
      sha256 "6d31d2a1f3b84231d58f39e4f914daef433acfb9dc50911b86b024acf57a147f"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.22-linux-aarch64-musl.tar.gz"
      sha256 "257e8f571614b88596558bf485aecd7b986fab0fba9175e6e9a8531cda58bc11"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.22-linux-x86_64-musl.tar.gz"
      sha256 "08316561da595193437253447917ab0cbb5501bc09eb9ba9cbe112f99f92dfea"
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
