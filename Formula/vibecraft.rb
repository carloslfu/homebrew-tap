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
#   v0.70.24            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   fc674716b827b25f1cc81cc426a224a325d31fda1c16a62e087f92e8a787d829   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   99f08ca614f7537c5310b1459d07168e56ec5536e624ca9cfe3658bfabc619b7   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   53afcc7c84f04e32488e9e937c0c9b22ed01a1fd187ea62da791225ca0589b4b    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   f1d463742cbf8a40a7b3e876dbfc8eff236ece3a6c66b126e184ea81bd933dd0    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.24"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "fc674716b827b25f1cc81cc426a224a325d31fda1c16a62e087f92e8a787d829"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "99f08ca614f7537c5310b1459d07168e56ec5536e624ca9cfe3658bfabc619b7"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "53afcc7c84f04e32488e9e937c0c9b22ed01a1fd187ea62da791225ca0589b4b"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "f1d463742cbf8a40a7b3e876dbfc8eff236ece3a6c66b126e184ea81bd933dd0"
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
