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
#   v0.70.19            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   525d8687531c9893d33e86e7fffdb831b35d071ddd09edbe6da0a63669d4e224   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   e165af15c2256bf0f93b36b0938f57f38254477f91eb97bdcbf24f7564a4d47e   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   abb1b54164da10f1815671749ade41575ec95daaa77cc9a578421d358696bad8    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   474377bdde6fd840fe2f02fd5b07a5bc014d996dc11bda7032c87f2595f3bd9d    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.19"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "525d8687531c9893d33e86e7fffdb831b35d071ddd09edbe6da0a63669d4e224"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "e165af15c2256bf0f93b36b0938f57f38254477f91eb97bdcbf24f7564a4d47e"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "abb1b54164da10f1815671749ade41575ec95daaa77cc9a578421d358696bad8"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "474377bdde6fd840fe2f02fd5b07a5bc014d996dc11bda7032c87f2595f3bd9d"
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
