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
#   v0.71.2            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   c446a0e2fb27bcd77a5e471d0b3376e9550ef12fd84244845efaccee96cfbca3   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   75fce8031a05b5248eff8f72fa77299b511a203f276e8a784031a62ab359c299   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   4be5cb680eabaf23bfeca0127979240d90933ed31c9c47a38a527f969351743c    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   11fd1de690daf06129b076bec8335de3cbaa8628c885834fc9824d0938316059    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "c446a0e2fb27bcd77a5e471d0b3376e9550ef12fd84244845efaccee96cfbca3"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "75fce8031a05b5248eff8f72fa77299b511a203f276e8a784031a62ab359c299"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "4be5cb680eabaf23bfeca0127979240d90933ed31c9c47a38a527f969351743c"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "11fd1de690daf06129b076bec8335de3cbaa8628c885834fc9824d0938316059"
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
