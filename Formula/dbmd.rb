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
# per release tag, substituting 0.3.5 + the per-target sha256 values from
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
  version "0.3.5"

  BASE = "https://github.com/carloslfu/db.md/releases/download/v0.3.5".freeze

  on_macos do
    on_arm do
      url "#{BASE}/dbmd-0.3.5-darwin-aarch64.tar.gz"
      sha256 "7c5bb34cff21876057998f9794bdd9fdcc5efb82c23a285d12a2fc852334058f"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.5-darwin-x86_64.tar.gz"
      sha256 "e74a78009ac00652757d55fb8659a563701741e15c10db97cc2c654fad3c3e96"
    end
  end

  on_linux do
    on_arm do
      url "#{BASE}/dbmd-0.3.5-linux-aarch64-musl.tar.gz"
      sha256 "31c44ba66a86513617a89b3897bb3b497409d947c5f3217f49aebcb933b5a9fd"
    end
    on_intel do
      url "#{BASE}/dbmd-0.3.5-linux-x86_64-musl.tar.gz"
      sha256 "6a1a073089c3f5aba0314c0ea74527658d01995e059fae33057261e0893ac75a"
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
