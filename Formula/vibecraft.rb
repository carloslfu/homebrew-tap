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
#   v0.70.17            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   acbdbc4e9e8c53dee086c0062dcd16171c7c147d296c99ee5d0e2aa32080475a   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   d52d30826af5e2a401b8a83d2b9c38f29059b9fbf0b4f89ad523651733719917   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   ee13be9d1db9ffbb820797f6e0345b61e2ce0ea8b9a2ea1be3bc180ad00f0646    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   d46a9856d96a7daef928ba3b7a639af084a9328bb6c95fedb28c108c9f0a33aa    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.17"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "acbdbc4e9e8c53dee086c0062dcd16171c7c147d296c99ee5d0e2aa32080475a"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "d52d30826af5e2a401b8a83d2b9c38f29059b9fbf0b4f89ad523651733719917"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "ee13be9d1db9ffbb820797f6e0345b61e2ce0ea8b9a2ea1be3bc180ad00f0646"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "d46a9856d96a7daef928ba3b7a639af084a9328bb6c95fedb28c108c9f0a33aa"
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
