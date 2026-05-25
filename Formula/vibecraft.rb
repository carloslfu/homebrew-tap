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
#   v0.70.0            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   dea1363f9923e7966d016aaeb32612376b27359baa80753b4d19d45568097226   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   c48955791970a33fa15ec1da23a606d6646bb322fad671a9027eb04008d66721   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   9f88317ffc6682a3137dcb794be35f6d77c7bdeec966fb5a5e2d80f040a8c698    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   289e4c8213c23f3405e6a7e9356f8ba5ba31ade462ea8d64a238fd62d133333e    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "dea1363f9923e7966d016aaeb32612376b27359baa80753b4d19d45568097226"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "c48955791970a33fa15ec1da23a606d6646bb322fad671a9027eb04008d66721"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "9f88317ffc6682a3137dcb794be35f6d77c7bdeec966fb5a5e2d80f040a8c698"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "289e4c8213c23f3405e6a7e9356f8ba5ba31ade462ea8d64a238fd62d133333e"
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
