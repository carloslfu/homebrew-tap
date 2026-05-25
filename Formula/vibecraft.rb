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
#   v0.70.8            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   1d2cc7d0db4707bd38a667e6f71e1ac747fb6773ab443e06999304b8bc78c0ba   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   c83eeace0ef252b2ea8025ab1a3d51c8082bfa35eab89155ef4a4182e8d3d906   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   b9021ad5beb37706ad6b62b1ca256d04ac6355888b59b951f8dbfa561a1c4422    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   66234b60b2e11cbc128a1de41b5c81ee130bc2529f316fb68c60181048658e8c    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.8"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "1d2cc7d0db4707bd38a667e6f71e1ac747fb6773ab443e06999304b8bc78c0ba"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "c83eeace0ef252b2ea8025ab1a3d51c8082bfa35eab89155ef4a4182e8d3d906"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "b9021ad5beb37706ad6b62b1ca256d04ac6355888b59b951f8dbfa561a1c4422"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "66234b60b2e11cbc128a1de41b5c81ee130bc2529f316fb68c60181048658e8c"
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
