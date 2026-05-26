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
#   v0.71.0            v0.X.Y
#   https://www.vibecraft.so/install/vibecraft-darwin-arm64   https://www.vibecraft.so/install/vibecraft-darwin-arm64
#   708119b5337a634aefc0e1a30aba56e8c4cd49243b92ea8e22b205630e50e02c   sha256 hex
#   https://www.vibecraft.so/install/vibecraft-darwin-amd64   ...
#   8d42ebcc948d7889dfdfaa97b7229f34fc684efc2ca0f4b5721978b5efe3371d   ...
#   https://www.vibecraft.so/install/vibecraft-linux-arm64    ...
#   f1b7c69859f6000d2dad5b4f6d15bdf524a92dfc361860fc83a8d7dea2dbcf0e    ...
#   https://www.vibecraft.so/install/vibecraft-linux-amd64    ...
#   5e5131e6eed8c481069b8150d5bcd7ee4cb8447b650bdebd26208c8807b198e4    ...

class Vibecraft < Formula
  desc "Agent-native CLI for the VibeCraft computer"
  homepage "https://www.vibecraft.so"
  version "v0.71.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-darwin-arm64"
      sha256 "708119b5337a634aefc0e1a30aba56e8c4cd49243b92ea8e22b205630e50e02c"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-darwin-amd64"
      sha256 "8d42ebcc948d7889dfdfaa97b7229f34fc684efc2ca0f4b5721978b5efe3371d"
    end
  end

  on_linux do
    on_arm do
      url "https://www.vibecraft.so/install/vibecraft-linux-arm64"
      sha256 "f1b7c69859f6000d2dad5b4f6d15bdf524a92dfc361860fc83a8d7dea2dbcf0e"
    end
    on_intel do
      url "https://www.vibecraft.so/install/vibecraft-linux-amd64"
      sha256 "5e5131e6eed8c481069b8150d5bcd7ee4cb8447b650bdebd26208c8807b198e4"
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
