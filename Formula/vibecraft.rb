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
#   v0.71.12            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   1b19d3503b98aaef9ded5b85a291023df67084e69240c0558d0c002bc80539ad   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   1a8da822cd4a895b071a3acbb9de34b4ee566d8adfab379bc4c2e3aa00abf153   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   04958ae4222ca6fc723dc49d68773a3f649940117dc08dd3b1a90f9ba13e06d9    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   c06f41bb221e19a51a0a4c3dc27e84bd6679417b784d58a6830910b2b44bc835    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.12"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "1b19d3503b98aaef9ded5b85a291023df67084e69240c0558d0c002bc80539ad"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "1a8da822cd4a895b071a3acbb9de34b4ee566d8adfab379bc4c2e3aa00abf153"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "04958ae4222ca6fc723dc49d68773a3f649940117dc08dd3b1a90f9ba13e06d9"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "c06f41bb221e19a51a0a4c3dc27e84bd6679417b784d58a6830910b2b44bc835"
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
