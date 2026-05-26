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
#   v0.70.23            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   8ceb7c44c0161b9998269e7606ddb4b127c574d99cca72167b6109afff964268   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   da5e234fcecdda6a11430580126975b8368a11275830c6da79f9591f0be85cbf   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   d8a954b701c8b068bfb55b9bcc4a4b8ea07f2d356ccba47df43779a658025ead    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   cd3fcbfffd44e13d29d417a9b921d0c3ba132730bbcf3ea48930623c8f40ba8d    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.23"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "8ceb7c44c0161b9998269e7606ddb4b127c574d99cca72167b6109afff964268"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "da5e234fcecdda6a11430580126975b8368a11275830c6da79f9591f0be85cbf"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "d8a954b701c8b068bfb55b9bcc4a4b8ea07f2d356ccba47df43779a658025ead"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "cd3fcbfffd44e13d29d417a9b921d0c3ba132730bbcf3ea48930623c8f40ba8d"
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
