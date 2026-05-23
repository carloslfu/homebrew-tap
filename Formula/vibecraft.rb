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
#   v0.67.0            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   927aff360a45757b19cfcd590173ff718d9e4282e82982e696eea7154fd9fba0   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   bf553aa0c865a30735da293e7c97ca6b164a9381001a311073f24eb2e499d9ab   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   5ad2d5f0a1ea5bca4e19e35bdd876fe91667eb893e0dcdebed01c46b104d86cb    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   66dbd48e5d5fc0dbf073e8a70f5848444abc4ea3dd92724252c8380f7e73d746    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.67.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "927aff360a45757b19cfcd590173ff718d9e4282e82982e696eea7154fd9fba0"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "bf553aa0c865a30735da293e7c97ca6b164a9381001a311073f24eb2e499d9ab"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "5ad2d5f0a1ea5bca4e19e35bdd876fe91667eb893e0dcdebed01c46b104d86cb"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "66dbd48e5d5fc0dbf073e8a70f5848444abc4ea3dd92724252c8380f7e73d746"
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
