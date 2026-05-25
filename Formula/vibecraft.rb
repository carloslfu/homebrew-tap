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
#   v0.70.4            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   cb41be3f3ce459a56157ddbb995fc863b208b9e0c1fe94600b91245657a8db6d   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   0ed41c714fb4f560d110c0ed7c19857c4d22b4e86ad388df6391714f901a73a5   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   6f68c0a1dfa0f1b4bd2334c16a6e3ce97270103c7ddcf82580913590c740de5f    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   20a83c9eb8f8cd6845927a87902bc36dce02b758d4d24c5d59a8a1ebedec54c9    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "cb41be3f3ce459a56157ddbb995fc863b208b9e0c1fe94600b91245657a8db6d"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "0ed41c714fb4f560d110c0ed7c19857c4d22b4e86ad388df6391714f901a73a5"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "6f68c0a1dfa0f1b4bd2334c16a6e3ce97270103c7ddcf82580913590c740de5f"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "20a83c9eb8f8cd6845927a87902bc36dce02b758d4d24c5d59a8a1ebedec54c9"
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
