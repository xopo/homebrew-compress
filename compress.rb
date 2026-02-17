class Compress < Formula
  desc "Compress is a file watcher that monitors ~/Desktop/screenshots for *.mov files and converts it to *.mp4 using Ffmpeg"
  homepage "https://github.com/xopo/compress"
  version "v0.5beta"
  url "https://github.com/xopo/compress/releases/download/v0.5beta/compress.tar.gz"
  sha256 "37eb3afe6902c9d7a2b1095ad18ccc72a4c6a8568d174c7ea2a298c17c6a46fe"
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
