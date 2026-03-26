class Telegramtui < Formula
  desc "Telegram TUI client for the terminal, inspired by lazygit"
  homepage "https://github.com/k4dy/telegramtui"
  version "1.0.0"

  url "https://github.com/k4dy/telegramtui/releases/download/v#{version}/telegramtui-#{version}.jar"
  sha256 "405bd5ed8f70b84ae3bf2a189be0c1a30da22923b745330c1463f1b3c087a1fc"

  depends_on "openjdk@21"
  depends_on "tdlib"

  def install
    libexec.install "telegramtui-#{version}.jar" => "telegramtui.jar"

    tdlib_lib = Formula["tdlib"].opt_lib
    java_bin  = Formula["openjdk@21"].opt_bin/"java"

    (bin/"telegramtui").write <<~EOS
      #!/bin/bash
      exec "#{java_bin}" \
        -Djna.library.path="#{tdlib_lib}" \
        -jar "#{libexec}/telegramtui.jar" "$@"
    EOS
  end

  test do
    assert_predicate bin/"telegramtui", :exist?
    assert_predicate libexec/"telegramtui.jar", :exist?
  end
end
