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
#   v0.71.17            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   3353bffc711bb3e55cda27b279fcdfa7ae54b261404a5bfb29f55b89e93d2348   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   deb8f4776bf0695c73e87f8965e6b129a201b055cf9bd753dd1293cca35b618f   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   72590a0921f6876e41d91926c8211852b335e63d61e6edbcf36a5be196e57faa    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   3d46538f094ac2af5b56dd06d28ab0d5755205366af1650fbdef983f05e932b2    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.17"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "3353bffc711bb3e55cda27b279fcdfa7ae54b261404a5bfb29f55b89e93d2348"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "deb8f4776bf0695c73e87f8965e6b129a201b055cf9bd753dd1293cca35b618f"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "72590a0921f6876e41d91926c8211852b335e63d61e6edbcf36a5be196e57faa"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "3d46538f094ac2af5b56dd06d28ab0d5755205366af1650fbdef983f05e932b2"
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
