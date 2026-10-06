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
# per release tag, substituting 0.14.3 + the per-target sha256 values from
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
  version "0.14.3"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.14.3".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.14.3-darwin-aarch64.tar.gz"
      sha256 "65afdb469389738f3f4d129658bc2b34fdbc67e1b39247d875f257776f57a7c7"
    end
    on_intel do
      url "#{BASE}/dbmd-0.14.3-darwin-x86_64.tar.gz"
      sha256 "bd3a98ad38b4d0d8ac104c500822602bb24f24de565c87032c26e9cd95173e91"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.14.3-linux-aarch64-musl.tar.gz"
      sha256 "3717e3d03d257dbe043dfa44b83e833329e33e77251a0b1d59ac32ce63f36bb8"
    end
    on_intel do
      url "#{BASE}/dbmd-0.14.3-linux-x86_64-musl.tar.gz"
      sha256 "76c065c348da38014c4b6d00bb08ea3a83175d72b7fab7a86c81ea679a69f189"
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
