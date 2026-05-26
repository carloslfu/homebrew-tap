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
#   v0.70.26            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   364728a2cc06113b0ed877888acd2f9c5a2ee00818b16551246e7d7a6c58c096   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   032382f69f2c51a3d1c3d468cd2bef641726e7e1793ff5c26be4fb79e2e45eca   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   b98f1497ce36511903054a78f0022a0b3edb9c8e381ddec40b363934a3166cb2    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   b46764a5cfc88a1b5fcc35a66f4ab5e4631b4086e2402179c4c84583dc7e1e9d    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.26"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "364728a2cc06113b0ed877888acd2f9c5a2ee00818b16551246e7d7a6c58c096"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "032382f69f2c51a3d1c3d468cd2bef641726e7e1793ff5c26be4fb79e2e45eca"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "b98f1497ce36511903054a78f0022a0b3edb9c8e381ddec40b363934a3166cb2"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "b46764a5cfc88a1b5fcc35a66f4ab5e4631b4086e2402179c4c84583dc7e1e9d"
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
