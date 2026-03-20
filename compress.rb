class Compress < Formula
  desc "Compress is a file watcher that monitors ~/Desktop/screenshots for *.mov files and converts it to *.mp4 using Ffmpeg"
  homepage "https://github.com/xopo/compress"
  version "v0.6.1.beta"
  url "https://github.com/xopo/compress/releases/download/v0.6.1.beta/compress.bin"
  sha256 "9226e9a9fb46620a87001bec4633aa681ee9b74f35a2191e64ccee5bc7de47d1"
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
    working_dir var
    #log_path var/"log/compress.log"
    #error_log_path var/"log/compress-error.log"
  end

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/compress.bin</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <false/>
        <key>WatchPaths</key>
        <array>
          <string>#{Dir.home}/Desktop/Screenshots</string>
        </array>
        <key>StandardOutPath</key>
        <string>#{var}/log/odin_watcher.log</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/odin_watcher.log</string>
      </dict>
      </plist>
    EOS
  end

end
