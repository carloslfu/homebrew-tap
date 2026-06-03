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
# per release tag, substituting 0.3.1 + the per-target sha256 values from
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
  version "0.3.1"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.3.1".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.3.1-darwin-aarch64.tar.gz"
      sha256 "1650ff670c2901415b53d6ba4a8b6752615ab2bb6763c23f518deb0ffb49feb5"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.1-darwin-x86_64.tar.gz"
      sha256 "b43c6693eaa0b52d38d11e7ad2db5c889d5667585e5f4227064a49c65f430ffc"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.3.1-linux-aarch64-musl.tar.gz"
      sha256 "37c7597920aef5a45a6da6f74403b1cee01f9d56054c8f1b7d5dc642596f998b"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.1-linux-x86_64-musl.tar.gz"
      sha256 "30ba2ff60c5c39f884db7bb90a34514ba529113e6cca3ce604a7de75006cdeba"
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
