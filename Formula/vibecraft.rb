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
#   v0.71.14            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   ca0c812939c96a5c5ada493c672c9fefae4ae33d69a0d6321699dbb910dec1f6   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   9fa61401bc6c39914687bd6a97bf489e36eb497e92dda628517cf8a73128f9f0   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   943e349bab0e7a0054872507ea9fa215ace9c834f23e83f996fe8ab2f5441d56    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   1034bf2c4976124b96f9843cf67f295900fc53647f450e3f5fcabe0c015c0c0e    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.14"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "ca0c812939c96a5c5ada493c672c9fefae4ae33d69a0d6321699dbb910dec1f6"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "9fa61401bc6c39914687bd6a97bf489e36eb497e92dda628517cf8a73128f9f0"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "943e349bab0e7a0054872507ea9fa215ace9c834f23e83f996fe8ab2f5441d56"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "1034bf2c4976124b96f9843cf67f295900fc53647f450e3f5fcabe0c015c0c0e"
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
