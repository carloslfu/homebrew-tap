# SPDX-License-Identifier: Apache-2.0

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
#   v0.71.6            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   410abb4151e01196751f230b5255f4f7661a2eba23821e1b2091068c2806a2ec   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   b0ee141d11a6c4e2e30e979c5911ca03cad627756516f129098adf92d2ddaaa6   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   7505d647b5606e2a35a44b46d7e00b9c66b521d1954b0392bb782ecb154096da    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   a1d1b1c23e4f04f46c5a37b0d8ec11e7f41a13478b5b91737ce6e553c9df76ae    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "410abb4151e01196751f230b5255f4f7661a2eba23821e1b2091068c2806a2ec"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "b0ee141d11a6c4e2e30e979c5911ca03cad627756516f129098adf92d2ddaaa6"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "7505d647b5606e2a35a44b46d7e00b9c66b521d1954b0392bb782ecb154096da"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "a1d1b1c23e4f04f46c5a37b0d8ec11e7f41a13478b5b91737ce6e553c9df76ae"
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
