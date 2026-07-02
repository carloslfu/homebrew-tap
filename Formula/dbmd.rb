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
# per release tag, substituting 0.6.1 + the per-target sha256 values from
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
  version "0.6.1"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.6.1".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.6.1-darwin-aarch64.tar.gz"
      sha256 "35c635512d84406a3bff2fe13867bb182a1a9c7e2fc60fdc192fee73d6c90772"
    end
    on_intel do
      url "#{BASE}/dbmd-0.6.1-darwin-x86_64.tar.gz"
      sha256 "c30cbdb9263312e083aae8635d6ca0547a2f49717f593a0c27e94a9ce97021db"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.6.1-linux-aarch64-musl.tar.gz"
      sha256 "2770c62b94701d19126c40fa25a387590559747b17ba2e894c495366c6cb1c4b"
    end
    on_intel do
      url "#{BASE}/dbmd-0.6.1-linux-x86_64-musl.tar.gz"
      sha256 "99dc42180c8a45a8f6291d4b0e5d20bce172ea4f9d1187518c1186d71bbdcf19"
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
