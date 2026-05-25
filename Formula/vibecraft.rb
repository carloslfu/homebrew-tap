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
#   v0.70.2            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   bd3182c9cbbc3b67f25f9f9342d11f5bb12d0ab7659d2d1b9eb27898e1b3aa53   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   e29c9c1aae61b32bd429d6e87624fac3690845006ef666cf18cd1483a8220687   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   0322a3268f8b6f45b81042e55814491c8710ca478db5f535bb292cac3bd3371d    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   b32d7acad4f90fee48bbcaf239e27d6d62ba418ffec7f44728c88497a6db9911    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "bd3182c9cbbc3b67f25f9f9342d11f5bb12d0ab7659d2d1b9eb27898e1b3aa53"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "e29c9c1aae61b32bd429d6e87624fac3690845006ef666cf18cd1483a8220687"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "0322a3268f8b6f45b81042e55814491c8710ca478db5f535bb292cac3bd3371d"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "b32d7acad4f90fee48bbcaf239e27d6d62ba418ffec7f44728c88497a6db9911"
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
