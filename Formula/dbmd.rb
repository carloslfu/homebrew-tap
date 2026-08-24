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
# per release tag, substituting 0.8.26 + the per-target sha256 values from
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
  version "0.8.26"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.26".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.26-darwin-aarch64.tar.gz"
      sha256 "cc23505a13c286b48cd47098ba76791054ec86222b554399911cb7f371c7ee0c"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.26-darwin-x86_64.tar.gz"
      sha256 "3287698f4423df804ce0647c1179c7371591395158554acb9ed066fd5143e1b9"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.26-linux-aarch64-musl.tar.gz"
      sha256 "25a538390f9fa6adbc6b686b64f71289460e87481a00ad8534004ec354a48309"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.26-linux-x86_64-musl.tar.gz"
      sha256 "0f075239d9f863d1476250474e27356ad180ce19d4b99fe457b13175935b0c92"
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
