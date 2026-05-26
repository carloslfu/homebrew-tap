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
#   v0.70.12            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   f8f237c5e1df9e3d008dae61ac4f76877b20cfe4393a768190f90dd52b91b99b   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   e7cd440c82c8e6b50a2367e1dbd31865455f35e2784e816c029bd59f50843e75   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   c101ade26b8acf5a4980f018836d3685198a86e0b3b533b3c04acf83eb2b8e6d    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   aef23e63279f5495c5c0042d470b7c61d67c068556f48e9b067c4381888256bf    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.12"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "f8f237c5e1df9e3d008dae61ac4f76877b20cfe4393a768190f90dd52b91b99b"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "e7cd440c82c8e6b50a2367e1dbd31865455f35e2784e816c029bd59f50843e75"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "c101ade26b8acf5a4980f018836d3685198a86e0b3b533b3c04acf83eb2b8e6d"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "aef23e63279f5495c5c0042d470b7c61d67c068556f48e9b067c4381888256bf"
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
