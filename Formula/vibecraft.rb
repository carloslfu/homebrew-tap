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
#   v0.66.0            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   8e8d5f099975fc159271c6347171919a486ea032a0d9ad74a1869785c2c0acf2   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   3c6326298025e26bacc202d916e5b80b766459fc208f93b0baf18c70ea56c7c7   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   735c7ceffa974256543c0e00ad81506926630ed3447f8f0281891559d51ce360    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   dd2b4ff826f059164929c7d8d9aae079c4b3563bbf81efc25e1a31cffb6b2246    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.66.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "8e8d5f099975fc159271c6347171919a486ea032a0d9ad74a1869785c2c0acf2"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "3c6326298025e26bacc202d916e5b80b766459fc208f93b0baf18c70ea56c7c7"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "735c7ceffa974256543c0e00ad81506926630ed3447f8f0281891559d51ce360"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "dd2b4ff826f059164929c7d8d9aae079c4b3563bbf81efc25e1a31cffb6b2246"
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
