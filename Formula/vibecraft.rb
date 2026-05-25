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
#   v0.70.6            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   87b33f0f3fba8e994bc8c9273df28a76fec98e47e8b4ca8c0986bc7cebd47f7d   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   ca8c545228461878cb75f11af76493a30abf3b409f7468cd93368656f0d7da49   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   82341d5c6360ec31bd0edb3f2252094083cb5d64a28b0a5efb0bbf944e13bc30    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   8e04553eca6ae31c44e255e51266741065a7d26c764cbf27454aae0e5e4c7c10    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "87b33f0f3fba8e994bc8c9273df28a76fec98e47e8b4ca8c0986bc7cebd47f7d"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "ca8c545228461878cb75f11af76493a30abf3b409f7468cd93368656f0d7da49"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "82341d5c6360ec31bd0edb3f2252094083cb5d64a28b0a5efb0bbf944e13bc30"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "8e04553eca6ae31c44e255e51266741065a7d26c764cbf27454aae0e5e4c7c10"
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
