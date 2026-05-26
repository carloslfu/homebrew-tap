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
#   v0.70.15            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   992545da070373956712ae58bf68877962d85d5c5d79433be2f3423d7547e52f   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   e383cc57e4abff9e5929cff04b3d2a1537f22266488139c027d9c2b992bfc4e5   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   853cdae4fddbab0c484afbb74ea487b08d4470630ee9ec83b7537f532d364ea1    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   dcc0fb1c2f8643f26543af7bc5cf136e1d5fef19499f6d266ef9b4fa284ea631    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.70.15"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "992545da070373956712ae58bf68877962d85d5c5d79433be2f3423d7547e52f"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "e383cc57e4abff9e5929cff04b3d2a1537f22266488139c027d9c2b992bfc4e5"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "853cdae4fddbab0c484afbb74ea487b08d4470630ee9ec83b7537f532d364ea1"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "dcc0fb1c2f8643f26543af7bc5cf136e1d5fef19499f6d266ef9b4fa284ea631"
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
