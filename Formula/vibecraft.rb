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
#   v0.71.9            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   dc41411840849a544bcd6f014db1779b7970a94f4af71b5eebed7beab3fee7e4   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   6b3442ee07e63513dee97cde7b14c51478ee091725df5c0a68a7af2910532452   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   b9ef28898b37fa4a117f41b6d9e67777b95fd181ea5ca1dbb4c8cd25839025a8    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   511972a558937f4659ff6327370d225576993f8c7dccadba37ab063ecd1d795a    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.9"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "dc41411840849a544bcd6f014db1779b7970a94f4af71b5eebed7beab3fee7e4"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "6b3442ee07e63513dee97cde7b14c51478ee091725df5c0a68a7af2910532452"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "b9ef28898b37fa4a117f41b6d9e67777b95fd181ea5ca1dbb4c8cd25839025a8"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "511972a558937f4659ff6327370d225576993f8c7dccadba37ab063ecd1d795a"
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
