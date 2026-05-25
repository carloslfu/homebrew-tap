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
#   v0.70.1            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   a2289b4c66195c52608da42cf31b6cdaed2544d97c99d2e0bd79d7cb07b11570   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   66a19673168f8ba8f860e730ece066836632b5f8bd5db97cd29c6941a5f608aa   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   fa2c00b0f5a60940684ec3e493d23211d1494131d06fc217dfb060441f0a866b    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   6b57cff9aeedcdd526e816b07319799115b5e6fc7df9c637ebdfa45be1eb9f0d    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "a2289b4c66195c52608da42cf31b6cdaed2544d97c99d2e0bd79d7cb07b11570"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "66a19673168f8ba8f860e730ece066836632b5f8bd5db97cd29c6941a5f608aa"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "fa2c00b0f5a60940684ec3e493d23211d1494131d06fc217dfb060441f0a866b"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "6b57cff9aeedcdd526e816b07319799115b5e6fc7df9c637ebdfa45be1eb9f0d"
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
