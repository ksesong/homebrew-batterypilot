class Batterypilot < Formula
  desc "Script that enables/disables MacBook's battery charging around a target value."
  homepage "https://github.com/ksesong/batterypilot"
  url "https://github.com/ksesong/batterypilot/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "e02f260b0f1ce3fc468332fe9f9daddbedad313943fb92f6d34b4151f5d01868"

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
