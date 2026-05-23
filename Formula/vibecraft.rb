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
#   v0.68.0            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   14d545de5dd72209c9f9158f8186fe994a27ae2510f44f6c962beaf29fc0f643   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   bef021194e8088897e9eec54b24448e89900c07ceef698bac7a5bdbbeda08deb   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   42d51e965962d324799e2d4391a7e3dc49faf13ae1e746962d3ee0b8937caeac    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   e154e63def5a314c0137867318903b21821564a1397e2d98a7d584d28162e592    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.68.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "14d545de5dd72209c9f9158f8186fe994a27ae2510f44f6c962beaf29fc0f643"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "bef021194e8088897e9eec54b24448e89900c07ceef698bac7a5bdbbeda08deb"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "42d51e965962d324799e2d4391a7e3dc49faf13ae1e746962d3ee0b8937caeac"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "e154e63def5a314c0137867318903b21821564a1397e2d98a7d584d28162e592"
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
