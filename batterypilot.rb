class Batterypilot < Formula
  desc "Script that enables/disables MacBook's battery charging around a target value."
  homepage "https://github.com/ksesong/batterypilot"
  url "https://github.com/ksesong/batterypilot/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "d6499a13c8fbb341100b1cbe5f5ebc40acf26c3e3b45bb6201f321d4c2608e53"

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
