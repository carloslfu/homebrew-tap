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
#   v0.71.8            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   7d3bfa4acaa701f5710dd12d2cf5c0e5ef69c4f801b058973e699db81ff2ea5c   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   30a486855781dd5918899ff1658644ef858f3b4e8e0755fc01dd36e7a8cba5f5   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   1e3361f25fe5404fa63d7694f3e9fd4ccde6fc63c4b650022cf3f1f69f98f46f    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   391a31f49a18f3f3b5d60bc5be908432dbc83b73072289e30b5989d3cf382737    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.8"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "7d3bfa4acaa701f5710dd12d2cf5c0e5ef69c4f801b058973e699db81ff2ea5c"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "30a486855781dd5918899ff1658644ef858f3b4e8e0755fc01dd36e7a8cba5f5"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "1e3361f25fe5404fa63d7694f3e9fd4ccde6fc63c4b650022cf3f1f69f98f46f"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "391a31f49a18f3f3b5d60bc5be908432dbc83b73072289e30b5989d3cf382737"
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
