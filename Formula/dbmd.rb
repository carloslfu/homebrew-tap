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
# per release tag, substituting 0.11.0 + the per-target sha256 values from
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
  version "0.11.0"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.11.0".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.11.0-darwin-aarch64.tar.gz"
      sha256 "5ce96f80882f54217bf3535b1105443a1c7c8663b105f501ee9120b42bc1d7fa"
    end
    on_intel do
      url "#{BASE}/dbmd-0.11.0-darwin-x86_64.tar.gz"
      sha256 "ce119f65b26a3555722c4ec2195eacd36a6b20b9150d2bb33efe561f24df3aef"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.11.0-linux-aarch64-musl.tar.gz"
      sha256 "1fe81f1573de132846a2ab1933ba4c67e9a4bd0e4ecbe924e897afc524eb1ec5"
    end
    on_intel do
      url "#{BASE}/dbmd-0.11.0-linux-x86_64-musl.tar.gz"
      sha256 "c7c2af332db93a3dcd5a26ebfd098615637be35469320f5df7bbddf40b0ee4dd"
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
