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
#   v0.70.25            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   8ef647ba90f317f44260b79217cc132ad897df6a42eac8a9af1305815a8dc860   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   0e6a9bd68994ba0ffc0df8b1e042ea536d1ba27c1b0b03d79eb479ed78dbb7fe   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   e6fc37c2da3d000967ef11b08e60a748b2155987d1ef9f9604adba418dcbd6f0    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   34565f693d1cc5ff06f2ed3dcb49974e88ac890bae135471f0662c61d90879ba    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.25"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "8ef647ba90f317f44260b79217cc132ad897df6a42eac8a9af1305815a8dc860"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "0e6a9bd68994ba0ffc0df8b1e042ea536d1ba27c1b0b03d79eb479ed78dbb7fe"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "e6fc37c2da3d000967ef11b08e60a748b2155987d1ef9f9604adba418dcbd6f0"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "34565f693d1cc5ff06f2ed3dcb49974e88ac890bae135471f0662c61d90879ba"
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
