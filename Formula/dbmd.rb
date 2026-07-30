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
# per release tag, substituting 0.8.2 + the per-target sha256 values from
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
  version "0.8.2"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.8.2".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.8.2-darwin-aarch64.tar.gz"
      sha256 "ffb95ae6214224e67eb3b298ca601a525e1c8b629bece593bdd4d4ba7095a883"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.2-darwin-x86_64.tar.gz"
      sha256 "4755897aab7bd2271181ac6aba3580407af410f65f7409728bb3acbb22064df1"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.8.2-linux-aarch64-musl.tar.gz"
      sha256 "1bd3330c040798138f893513dd1a0545e79dbd609ce5cd1657e58eabb9521b45"
    end
    on_intel do
      url "#{BASE}/dbmd-0.8.2-linux-x86_64-musl.tar.gz"
      sha256 "cd8282bdb6b36d29a55d982b536e4f87cad43e1d500e2866091ceaf5b94aa5b1"
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
