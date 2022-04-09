class Batterypilot < Formula
  desc "Script that enables/disables MacBook's battery charging around a target value."
  homepage "https://github.com/ksesong/batterypilot"
  url "https://github.com/ksesong/batterypilot/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "291959352487bd9a2887a959fb2d7a0521c3db75a5e6155e25c3c7d989068c4d"

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
