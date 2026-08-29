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
# per release tag, substituting 0.12.0 + the per-target sha256 values from
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
  version "0.12.0"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.12.0".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.12.0-darwin-aarch64.tar.gz"
      sha256 "196e0c5fb0385bd1b3cef890131282294ed1469c6a23368bc819025ae49d7fe9"
    end
    on_intel do
      url "#{BASE}/dbmd-0.12.0-darwin-x86_64.tar.gz"
      sha256 "ab2d5e93ed0ae0050750dcb7adf5ebda55fb4100afd8f8f1e03423cd445cefbf"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.12.0-linux-aarch64-musl.tar.gz"
      sha256 "af24858a9277e27d1bb330b114f2cefa5a0c4f7545d5c93dc48eff2fc5266a98"
    end
    on_intel do
      url "#{BASE}/dbmd-0.12.0-linux-x86_64-musl.tar.gz"
      sha256 "d77c8b53d49c96cab41db302dc7d1931591d25e71a5b708746ad0bff3588ec9f"
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
