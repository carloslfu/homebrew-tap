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
#   v0.63.0            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   efd314b44b5a7ed3f521131a9c0e33fdde94be03620cf3d70204ad4ccd05f3fa   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   0e77e55eea809410bdadf39026ed7281d12bfc84d95776285d3df9b2b41d4044   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   26179f05285a4a69143339c2395b0f98a5bd2c1c395e72b9a981a8e1cc99e23e    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   9500b9ce81ceac16af300191f83c9e1607e3fd92f123fcf4a7aec115c43a0953    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.63.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "efd314b44b5a7ed3f521131a9c0e33fdde94be03620cf3d70204ad4ccd05f3fa"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "0e77e55eea809410bdadf39026ed7281d12bfc84d95776285d3df9b2b41d4044"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "26179f05285a4a69143339c2395b0f98a5bd2c1c395e72b9a981a8e1cc99e23e"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "9500b9ce81ceac16af300191f83c9e1607e3fd92f123fcf4a7aec115c43a0953"
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
