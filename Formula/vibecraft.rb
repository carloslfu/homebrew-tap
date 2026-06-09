# SPDX-License-Identifier: Apache-2.0

# typed: false
# frozen_string_literal: true

# Homebrew formula template for the VibeCraft CLI.
#
# This is the SOURCE template. The release pipeline (see
# .github/workflows/release.yml job `homebrew`) renders this with the
# concrete version + SHA-256 values, then pushes it to the public tap
# repo at github.com/carloslfu/homebrew-tap as Formula/vibecraft.rb.
#
# Users install with:
#
#   brew install carloslfu/tap/vibecraft
#
# Substitution variables (filled by the release job):
#   v0.71.11            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   e21f09caca27310ccf4ffe625c17f00d92faf80aef391fc898cf701469b26a86   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   c2b2fdd879dabb8b6727b63ece721afc0e69cab049b8a596b40612330fb0a883   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   292a0ab4570e322733b662f9edc24acb86f118e96075a0247398f82f42aaeb40    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   1752a45a781a195f472c18bdff6d7cbe0397bb948a920ab7e3fee9cfdec3bf8a    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.11"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "e21f09caca27310ccf4ffe625c17f00d92faf80aef391fc898cf701469b26a86"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "c2b2fdd879dabb8b6727b63ece721afc0e69cab049b8a596b40612330fb0a883"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "292a0ab4570e322733b662f9edc24acb86f118e96075a0247398f82f42aaeb40"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "1752a45a781a195f472c18bdff6d7cbe0397bb948a920ab7e3fee9cfdec3bf8a"
    end
  end

  def install
    # Release assets are bare binaries; rename to "vibecraft" before
    # putting them on PATH so the formula works the same way across
    # all four (os, arch) combinations.
    binary = Dir["vibecraft-*"].first
    bin.install binary => "vibecraft" if binary
    # Source-built fallback (in case someone untars + builds locally).
    bin.install "vibecraft" if File.exist?("vibecraft")
  end

  test do
    output = shell_output("#{bin}/vibecraft version --text")
    assert_match "vibecraft", output
  end
end
