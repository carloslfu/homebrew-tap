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
#   v0.69.0            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   6bb2ebfd8db14125ada8385e16249d65996538dfa6cd98c5ff4f80c55dca6bb5   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   dd7deb6921a7ad28b8ee7071a2135e405ead6eadd9dc7e47ea9167e9e0b998b2   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   613c6b8016804ba4217a5c12e0aa762760c65bef2dcf0c68215a1dfecc2cc273    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   2a34a80ee51fd51927837381cacf71e675f8cb2f2c92ec7c1c28225849d3a375    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.69.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "6bb2ebfd8db14125ada8385e16249d65996538dfa6cd98c5ff4f80c55dca6bb5"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "dd7deb6921a7ad28b8ee7071a2135e405ead6eadd9dc7e47ea9167e9e0b998b2"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "613c6b8016804ba4217a5c12e0aa762760c65bef2dcf0c68215a1dfecc2cc273"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "2a34a80ee51fd51927837381cacf71e675f8cb2f2c92ec7c1c28225849d3a375"
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
