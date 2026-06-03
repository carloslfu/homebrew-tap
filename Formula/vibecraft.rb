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
#   v0.71.7            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   331ff4b235f18fa7de5529446e15de034e73743f757bc076401a7388f8b50d93   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   f3fd416736117613ef4ab7b2f15573f8e08ea5cd59603d910c2e7a7c31c42c8b   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   8001321f2db00b6cc1982a113ff26202a341809ae2d7271c4f9b549455fe20c6    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   9c2d935a46acbffd0d9f174d2bc5e07c08fa40f7f6c420d78ddd47ae6a16a330    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.7"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "331ff4b235f18fa7de5529446e15de034e73743f757bc076401a7388f8b50d93"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "f3fd416736117613ef4ab7b2f15573f8e08ea5cd59603d910c2e7a7c31c42c8b"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "8001321f2db00b6cc1982a113ff26202a341809ae2d7271c4f9b549455fe20c6"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "9c2d935a46acbffd0d9f174d2bc5e07c08fa40f7f6c420d78ddd47ae6a16a330"
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
