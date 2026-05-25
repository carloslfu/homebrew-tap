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
#   v0.70.3            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   891092f5adc7df11bc2a1bfae99ec89d007e48baa78e2b2649216e537d985a20   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   2c183a4edbe449a985857ed0360f3b3066e76786fd9530558e53bf5b38433565   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   45c901f82ba6d6666d05daeecb63439ee5f2d2e0e72f2ac47c1aea2ca2a178d8    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   936c61f2de0c3897c6a430ec27bc4545ab6b7ccc7e0f7fa39177bc940e28edf1    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "891092f5adc7df11bc2a1bfae99ec89d007e48baa78e2b2649216e537d985a20"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "2c183a4edbe449a985857ed0360f3b3066e76786fd9530558e53bf5b38433565"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "45c901f82ba6d6666d05daeecb63439ee5f2d2e0e72f2ac47c1aea2ca2a178d8"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "936c61f2de0c3897c6a430ec27bc4545ab6b7ccc7e0f7fa39177bc940e28edf1"
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
