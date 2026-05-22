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
#   v0.65.0            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   b6052a7e050807551a5900a8e0b58eafc74a64cba242ea3bc03c3f27ce2a36bc   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   ff2a359dd2e5c08ff23364653606a141aa2555a8a5d05b6380d2084d3e0ccc66   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   859785260787125a8687c38814fd7ff31502a9de9e186ca9a9bfef9158e756d9    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   d79ddab67a516e2ded7f5d984b1f4fe448eb15301c2cbc22d7e6974b40c43204    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.65.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "b6052a7e050807551a5900a8e0b58eafc74a64cba242ea3bc03c3f27ce2a36bc"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "ff2a359dd2e5c08ff23364653606a141aa2555a8a5d05b6380d2084d3e0ccc66"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "859785260787125a8687c38814fd7ff31502a9de9e186ca9a9bfef9158e756d9"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "d79ddab67a516e2ded7f5d984b1f4fe448eb15301c2cbc22d7e6974b40c43204"
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
