class Batterypilot < Formula
  desc "Script that enables/disables MacBook's battery charging around a target value."
  homepage "https://github.com/ksesong/batterypilot"
  url "https://github.com/ksesong/batterypilot/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "8c1e68af78d1b35c34f4da416691e06072b3af62ebbccf359dc4ef190d6c0d2f"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "--bin", "batterypilot"
    libexec.install "target/release/smc"
    bin.install "target/release/batterypilot"
  end

  service do
    run opt_bin/"batterypilot"
    environment_variables SMC_PATH: opt_libexec/"smc"
  end

  test do
    assert_equal "is_charging_enabled: true", shell_output("#{bin}/batterypilot --read").strip
  end
end
