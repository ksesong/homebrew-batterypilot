class Batterypilot < Formula
  desc "Script that enables/disables MacBook's battery charging around a target value."
  homepage "https://github.com/ksesong/batterypilot"
  url "https://github.com/ksesong/batterypilot/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "d9b23ed8f67048286ecd529c1b9b9b89e4bf97db48b5c6f5657ab29aef882721"

  depends_on "rust" => :build

  def install
    ENV["SMC_PATH"] = opt_libexec/"smc"
    system "cargo", "build", "--release", "--bin", "batterypilot"
    libexec.install "target/release/smc"
    bin.install "target/release/batterypilot"
  end

  service do
    run opt_bin/"batterypilot"
  end

  test do
    assert_equal "is_charging_enabled: true", shell_output("#{bin}/batterypilot --read").strip
  end
end
