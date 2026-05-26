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
#   v0.70.10            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   392bf0b719aaaa621ae19cc7e315b90940c7215d2e7b9717a106ab67821eab11   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   860d64ebd92a3dac659ef0a97521f9a73048376796bee73c2f8c5598ab9976ab   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   2057d5d2c13eada7b58c01832e80295d890d5fac696cde2c1fc0b6bafbf7bb16    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   46e983002e8b9692b5a15d556c9decc6d18fe8a3ec4085f7cda06d5bcc80c489    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.10"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "392bf0b719aaaa621ae19cc7e315b90940c7215d2e7b9717a106ab67821eab11"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "860d64ebd92a3dac659ef0a97521f9a73048376796bee73c2f8c5598ab9976ab"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "2057d5d2c13eada7b58c01832e80295d890d5fac696cde2c1fc0b6bafbf7bb16"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "46e983002e8b9692b5a15d556c9decc6d18fe8a3ec4085f7cda06d5bcc80c489"
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
