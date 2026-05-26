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
#   v0.70.14            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   3960c29c8c72a5e1843f69812a51971bc82cd6b0330383fc5d822645ac9845f5   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   b83a6099e73ef7ecc727ddd3ec72fc2d8610043ed50bc8c3a82479cef4e9ff45   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   833d92749f17041856399a9b878008d577deee52355745b0157ec6493922fbfe    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   472d0dce6018bda514fb3c3392f275fe1d9af78234782a0330c2d25354240edc    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.14"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "3960c29c8c72a5e1843f69812a51971bc82cd6b0330383fc5d822645ac9845f5"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "b83a6099e73ef7ecc727ddd3ec72fc2d8610043ed50bc8c3a82479cef4e9ff45"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "833d92749f17041856399a9b878008d577deee52355745b0157ec6493922fbfe"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "472d0dce6018bda514fb3c3392f275fe1d9af78234782a0330c2d25354240edc"
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
