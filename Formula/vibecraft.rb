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
#   v0.71.1            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   a8ae974c881a3866fec9e16318d71a5698479da599b5aef1a1426ae4f46a8217   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   4cde91d7aba72662632b54d30a9f42a083894e890353978bac541e7f4c44ef49   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   837e1642341e7297a5b4a4179cbe85105d649bae3528688a6a015716de1b461d    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   141403e8aa9c71c935cab06718bd78810303849b7a049677a144d8150c2380f9    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "a8ae974c881a3866fec9e16318d71a5698479da599b5aef1a1426ae4f46a8217"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "4cde91d7aba72662632b54d30a9f42a083894e890353978bac541e7f4c44ef49"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "837e1642341e7297a5b4a4179cbe85105d649bae3528688a6a015716de1b461d"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "141403e8aa9c71c935cab06718bd78810303849b7a049677a144d8150c2380f9"
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
