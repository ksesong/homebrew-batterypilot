class Batterypilot < Formula
  desc "Script that enables/disables MacBook's battery charging around a target value."
  homepage "https://github.com/ksesong/batterypilot"
  url "https://github.com/ksesong/batterypilot/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "bfe3beef934a489844791d670df603f78657ac2042a7fc5bc0e088a532fd54d4"

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
