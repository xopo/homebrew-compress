class Compress < Formula
  desc "Compress is a file watcher that monitors ~/Desktop/screenshots for *.mov files and converts it to *.mp4 using Ffmpeg"
  homepage "https://github.com/xopo/compress"
  version "v0.2.beta"
  url "https://github.com/xopo/compress/releases/download/beta/compress.tar.gz"
  sha256 "4bf1bf13b51f4bc96d9e431ca8ef7a217871797eb195e2424b6f1f5034763701"
  license "MIT"

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "compress.bin"
    else 
      odie <<~EOS
        ❌ Unsupported platform. For now the Homebrew formula only suports:
        · Mac with Apple Silicon
        You can build the binary from source :https://github.com/xopo/compress
        EOS
    end
  end

  service do 
    run [opt_bin/"compress.bin", "-w"]
    keep_alive true
    #log_path var/"log/compress.log"
    #error_log_path var/"log/compress-error.log"
  end
end
