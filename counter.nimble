# Package

version       = "0.1.0"
author        = "CodeDoes"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["counter"]

# Dependencies

requires "nim >= 0.18.0"
requires "nimgame2 >= 0.5.0"
requires "colorsys >= 0.2"

task compile_run,"compile and run":
  exec "nim c -r -o: build/counter src/counter"