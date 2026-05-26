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
#   v0.70.22            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   c17a77a7ec8c53eacf004abe2abd29a8cacfa2a806e11211f84a1fd2dc9b1465   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   5d5a60b9190104910343c52e5f30dfcb01ae8d5d4d6a6b16a88235196942266f   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   30539e9804011723a61630e7526cce203ed524f793a898f46d5f6a06aaa180de    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   876b9bd803d11ff12d4ab77016f5f1916c9b0fa9255355c504cef2ef45781091    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.22"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "c17a77a7ec8c53eacf004abe2abd29a8cacfa2a806e11211f84a1fd2dc9b1465"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "5d5a60b9190104910343c52e5f30dfcb01ae8d5d4d6a6b16a88235196942266f"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "30539e9804011723a61630e7526cce203ed524f793a898f46d5f6a06aaa180de"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "876b9bd803d11ff12d4ab77016f5f1916c9b0fa9255355c504cef2ef45781091"
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
