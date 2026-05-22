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
#   v0.64.0            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   6616e6c3f25fb9f3e6c168aed91148acd0006533c5c8f80ae9c08b2936fe0210   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   e654eddaf3023d45354762199b92611053bc1b45a75cc3313c14bbc22ae9637d   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   e18dce2a4659e73187c25cb1f0f0ba2d7710b70ab9bdfa9aa3644e1baeb97026    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   36add46c81eb626333f9caf44f41cf54185e554b55ccbd01e83b7d292128a8b2    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.64.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "6616e6c3f25fb9f3e6c168aed91148acd0006533c5c8f80ae9c08b2936fe0210"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "e654eddaf3023d45354762199b92611053bc1b45a75cc3313c14bbc22ae9637d"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "e18dce2a4659e73187c25cb1f0f0ba2d7710b70ab9bdfa9aa3644e1baeb97026"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "36add46c81eb626333f9caf44f41cf54185e554b55ccbd01e83b7d292128a8b2"
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
