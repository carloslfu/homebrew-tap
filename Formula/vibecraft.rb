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
#   v0.71.4            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   221d708d76c90328f2df9129c89c6fcf137f66af8f372ebfa7acdc888bd11b86   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   4930027995833eae143fb043defb72f7d424b9750f28ca8a115d35427abc5c1e   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   4afdf530cfc272024dd492a6b0486306dd7a01e02a8f5137050e06517d998b25    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   6532269cbffa802a6a86b636017407b276c5cd73d622da6836cbc654f44f0b15    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "221d708d76c90328f2df9129c89c6fcf137f66af8f372ebfa7acdc888bd11b86"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "4930027995833eae143fb043defb72f7d424b9750f28ca8a115d35427abc5c1e"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "4afdf530cfc272024dd492a6b0486306dd7a01e02a8f5137050e06517d998b25"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "6532269cbffa802a6a86b636017407b276c5cd73d622da6836cbc654f44f0b15"
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
