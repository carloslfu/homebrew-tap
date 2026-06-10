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
#   v0.71.13            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   e4e27d874e754f9a2c6691e9af8f9d8e1ad026af270efe8402bd621843361194   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   06da3037c3b6223004e85c73ae9fd54d4f8a353d77bf55725027f740d11ec5a3   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   7b8ae38922a76a4bfd14aa81a63a5816a6485ff8c34ced115ceee4d22280e26e    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   dbb3e4b77837c31f3a682bca0274ad6197d51fb86346abc8020f3c033915cddc    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.13"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "e4e27d874e754f9a2c6691e9af8f9d8e1ad026af270efe8402bd621843361194"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "06da3037c3b6223004e85c73ae9fd54d4f8a353d77bf55725027f740d11ec5a3"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "7b8ae38922a76a4bfd14aa81a63a5816a6485ff8c34ced115ceee4d22280e26e"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "dbb3e4b77837c31f3a682bca0274ad6197d51fb86346abc8020f3c033915cddc"
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
