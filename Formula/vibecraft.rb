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
#   v0.70.16            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   467b1ad85a61784c8451ba4f17319f4f378acfbff3175f42ea286c486e4ba852   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   6e359d436535b6199fb2bf7ef9afc67ac866d4395ac73abf8b8fa422e9dbf74d   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   29ede58686108d377f4117d9b5af19a8eb8474e745128b3b5dc33a00ff17ae56    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   07e9f63086a77984ebd38a61f8deb4b8e02523bfd70b9e007ec4c6812f3e6120    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.16"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "467b1ad85a61784c8451ba4f17319f4f378acfbff3175f42ea286c486e4ba852"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "6e359d436535b6199fb2bf7ef9afc67ac866d4395ac73abf8b8fa422e9dbf74d"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "29ede58686108d377f4117d9b5af19a8eb8474e745128b3b5dc33a00ff17ae56"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "07e9f63086a77984ebd38a61f8deb4b8e02523bfd70b9e007ec4c6812f3e6120"
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
