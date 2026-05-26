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
#   v0.70.21            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   88c2b180dfb2e90c91f9ce961654dac431be32e0e15f418a2f2a820ec26c4903   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   83ee68967366cd2532e8606420528f5dd25e069b4430c01244ad7378de6e6e82   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   b2aade31bcbe2b8c0f0cf37e2eb9e47f23f2778fe383156330efffd17ab587cf    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   783a8962a8b153352fac7bfadebd903b421a02095a814746aa8a9f5b3943fe3d    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.21"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "88c2b180dfb2e90c91f9ce961654dac431be32e0e15f418a2f2a820ec26c4903"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "83ee68967366cd2532e8606420528f5dd25e069b4430c01244ad7378de6e6e82"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "b2aade31bcbe2b8c0f0cf37e2eb9e47f23f2778fe383156330efffd17ab587cf"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "783a8962a8b153352fac7bfadebd903b421a02095a814746aa8a9f5b3943fe3d"
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
