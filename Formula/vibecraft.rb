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
#   v0.70.9            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   018520ed5d2402daea7e614aa41783a765bf2ff8cd82f15bf8aa880aab6a5757   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   85fcc32740891261fbeb719c9a4a28ce9763ed26c80e1d2793a280b59481ad76   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   bd8d38d30cbcb4d60653eb46d868a759f83902f110c2fbd22ba63016c367937e    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   34b39ea9b0fca0ef1619c10ef757518fafca779a8877aecc3503404565db9bdc    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.9"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "018520ed5d2402daea7e614aa41783a765bf2ff8cd82f15bf8aa880aab6a5757"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "85fcc32740891261fbeb719c9a4a28ce9763ed26c80e1d2793a280b59481ad76"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "bd8d38d30cbcb4d60653eb46d868a759f83902f110c2fbd22ba63016c367937e"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "34b39ea9b0fca0ef1619c10ef757518fafca779a8877aecc3503404565db9bdc"
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
