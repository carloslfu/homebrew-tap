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
#   v0.70.20            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   6b1b672c05b3ad7d0b2a73db64a231e362c051370c6a55050a003b5290d723ae   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   097bdfbbb82c6e22c378b06f07328fd0a05e505b80538b4bdc46de852ec6e329   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   8a81897d33e88cd4175b9015d0b618d0a9119bac9f6f24cae19889d5c414a741    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   f331dc3aabc0b9ea043c98f386d9bced75924579ddaa8eb5f587cc0acb278d01    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.20"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "6b1b672c05b3ad7d0b2a73db64a231e362c051370c6a55050a003b5290d723ae"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "097bdfbbb82c6e22c378b06f07328fd0a05e505b80538b4bdc46de852ec6e329"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "8a81897d33e88cd4175b9015d0b618d0a9119bac9f6f24cae19889d5c414a741"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "f331dc3aabc0b9ea043c98f386d9bced75924579ddaa8eb5f587cc0acb278d01"
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
