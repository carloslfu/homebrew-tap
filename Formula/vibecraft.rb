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
#   v0.71.5            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   57472a72f3397cdac609bef2773bd7931ac6649d9eb847fa346ffa1925dae544   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   65b96a5fa7f376f1d6bf8148818e3723cd7e25dad10605f3daa9b95c74f40d39   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   b3651af6aba6ce2a1093bd4227135368185e4423047d3545ab80d7c1a10a3bc9    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   3e988270cfab4c5f51b78af4994fb544d232ad9f569c977bea13e0c5a180da84    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "57472a72f3397cdac609bef2773bd7931ac6649d9eb847fa346ffa1925dae544"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "65b96a5fa7f376f1d6bf8148818e3723cd7e25dad10605f3daa9b95c74f40d39"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "b3651af6aba6ce2a1093bd4227135368185e4423047d3545ab80d7c1a10a3bc9"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "3e988270cfab4c5f51b78af4994fb544d232ad9f569c977bea13e0c5a180da84"
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
