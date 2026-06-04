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
#   v0.71.10            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   eb0c1f4f6ffdaf61c9fe8bbc4aa2e93441f8c6f8bbfaf67dcec368489d5d9e2d   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   b7c813dc958b05526ce2b569246606b6d4a5720f0356d24bbc98953d52db8562   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   ecc58b53a34e0dc933bf61aa9a9bcfc5c3c519955b611455f388b16696c01d65    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   4b557d5ff9d341f08c41963d6402a601edb7815f935fb4c4db53a0ab2f08c63e    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.10"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "eb0c1f4f6ffdaf61c9fe8bbc4aa2e93441f8c6f8bbfaf67dcec368489d5d9e2d"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "b7c813dc958b05526ce2b569246606b6d4a5720f0356d24bbc98953d52db8562"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "ecc58b53a34e0dc933bf61aa9a9bcfc5c3c519955b611455f388b16696c01d65"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "4b557d5ff9d341f08c41963d6402a601edb7815f935fb4c4db53a0ab2f08c63e"
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
