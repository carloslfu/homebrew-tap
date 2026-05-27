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
#   v0.71.3            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   6bc5a0b90d2c9f572acf6e4e92c136d6da5833335cc26a3f4c4f231affc3e020   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   292ebcda1e703361c534d5ee15b8ff4a352587339dc7dedc015e210637eecc7a   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   9eea9ebdf40d30cd1f47b562df6afb1f806bd6ee2a6ac40d132a3236610b4d6f    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   29c7471a686516b0a071e5ecbb4bc9565ff987979a929191faf0409d55256514    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "6bc5a0b90d2c9f572acf6e4e92c136d6da5833335cc26a3f4c4f231affc3e020"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "292ebcda1e703361c534d5ee15b8ff4a352587339dc7dedc015e210637eecc7a"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "9eea9ebdf40d30cd1f47b562df6afb1f806bd6ee2a6ac40d132a3236610b4d6f"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "29c7471a686516b0a071e5ecbb4bc9565ff987979a929191faf0409d55256514"
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
