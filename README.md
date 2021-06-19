# GodotSwift

GodotSwift is experimental project to generate Swift API for [Godot Engine](https://godotengine.org/).  
Under the hood, `Generator` uses [swift-syntax](https://github.com/apple/swift-syntax) to generate Swift code from [Godot API](https://github.com/godotengine/godot-headers/blob/master/api.json).

Requires [swift-DEVELOPMENT-SNAPSHOT-2021-05-28-a](https://swift.org/builds/development/xcode/swift-DEVELOPMENT-SNAPSHOT-2021-05-28-a/swift-DEVELOPMENT-SNAPSHOT-2021-05-28-a-osx.pkg) toolchain.

## Usage

1. Build `Generator`
2. `./Generator <path to godot api.json> <path to output directory>` 

Example output from Generator: https://gist.github.com/nzatsepilov/4824e9ea989a39314837af5ba1bef40d

## TODO
  - [ ] Generate properties
  - [ ] Bridge [GDNative types](https://github.com/godotengine/godot-headers/tree/master/gdnative)
  - [ ] Generate method implementations (calling c-methods from godot)
  - [ ] Signals
  - [ ] Support for scripting
  
