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
#   v0.70.18            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   b473162bce578edd22e68909d600f4affce534d1571a7e3b06ba3e969a0929b6   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   629a0a46386e7d9f2d0fff5048944be6ad4bd1b2ea39ec9928837f818b48936d   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   2bfe76bfd92b272a6828094e6fcee2d491c3b56b7dfd109ab2eb4a31c4951276    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   ed1b9bd01aa927de4c22b438c201fbbea008ba68ab89aca5f0145a5b116b1073    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.18"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "b473162bce578edd22e68909d600f4affce534d1571a7e3b06ba3e969a0929b6"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "629a0a46386e7d9f2d0fff5048944be6ad4bd1b2ea39ec9928837f818b48936d"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "2bfe76bfd92b272a6828094e6fcee2d491c3b56b7dfd109ab2eb4a31c4951276"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "ed1b9bd01aa927de4c22b438c201fbbea008ba68ab89aca5f0145a5b116b1073"
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
