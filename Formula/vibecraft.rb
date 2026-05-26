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
#   v0.70.11            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   3df2ade6405d97b0bb569d6c8d149879e20626445ba0eb1040d444552fc07eab   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   2dd02677b08970889def49d7930727be3efda0546ecfe0947b51ac6f2f6f0ca5   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   0bde20e8d089f833d4aa62bc98ea5c9fb197b16da32a67ad37398c8545d47a35    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   f21e80994d6a893afa2de575e9b5f7ab2ee3b4d379d784b1cfdad85118a9877e    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.11"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "3df2ade6405d97b0bb569d6c8d149879e20626445ba0eb1040d444552fc07eab"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "2dd02677b08970889def49d7930727be3efda0546ecfe0947b51ac6f2f6f0ca5"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "0bde20e8d089f833d4aa62bc98ea5c9fb197b16da32a67ad37398c8545d47a35"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "f21e80994d6a893afa2de575e9b5f7ab2ee3b4d379d784b1cfdad85118a9877e"
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
