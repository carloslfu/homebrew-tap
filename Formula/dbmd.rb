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
# per release tag, substituting 0.3.10 + the per-target sha256 values from
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
  version "0.3.10"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.3.10".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.3.10-darwin-aarch64.tar.gz"
      sha256 "a715c94b021a5ee92fc29900914f3e3b69d1af8e91d2d7cf4135383a64fb9d15"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.10-darwin-x86_64.tar.gz"
      sha256 "87676564ce299c1d5830a28030bf99f886c66c090334085e6a7c5d8f24f5d989"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.3.10-linux-aarch64-musl.tar.gz"
      sha256 "a87408ae21ea49a8ff4512ec3f6d30a2580b9a0eb445a0988c2567c4e0fa5b5d"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.10-linux-x86_64-musl.tar.gz"
      sha256 "712e1971518f7d1be56c3b3e4393bdb469e1992c8c73e23a0e59e3bc36bb6d90"
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
