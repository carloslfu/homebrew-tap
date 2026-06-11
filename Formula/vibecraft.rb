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
#   v0.71.15            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   cb4bc08ad4e94b8811ee0e6239f898ba598fe36847727b00c3e7ff53e4091eb3   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   d45544317992401dfc1de3edad0c92820c057d931a05788f2f971fad2234061c   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   a1c6afd1148623f1a99c707bdf615ed060c46c5b31f2fe3b9eea266d602fb36a    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   1d1feb49ffe42820dfc6a9979e5e281b1195c836292ef8e945f52ae4ecfb26d8    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.15"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "cb4bc08ad4e94b8811ee0e6239f898ba598fe36847727b00c3e7ff53e4091eb3"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "d45544317992401dfc1de3edad0c92820c057d931a05788f2f971fad2234061c"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "a1c6afd1148623f1a99c707bdf615ed060c46c5b31f2fe3b9eea266d602fb36a"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "1d1feb49ffe42820dfc6a9979e5e281b1195c836292ef8e945f52ae4ecfb26d8"
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
