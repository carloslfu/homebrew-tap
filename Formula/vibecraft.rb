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
#   v0.70.5            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   1f8897c53caf486e73e454061a6d8ec9507ed18210d25358434faac1669500ef   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   2a4179195691182201b6bda87e1b9d03afcec5447f830938966d453e51442daa   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   ab6bf7fb857c221080948cd18a01cfa5a08220fb75209f1b9a1b2f7db7539c41    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   4697e7a49b8e04b9e5cfa63fa0c2e7f63aca7c8d24ab96112f75e4dda6186fbb    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "1f8897c53caf486e73e454061a6d8ec9507ed18210d25358434faac1669500ef"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "2a4179195691182201b6bda87e1b9d03afcec5447f830938966d453e51442daa"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "ab6bf7fb857c221080948cd18a01cfa5a08220fb75209f1b9a1b2f7db7539c41"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "4697e7a49b8e04b9e5cfa63fa0c2e7f63aca7c8d24ab96112f75e4dda6186fbb"
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
