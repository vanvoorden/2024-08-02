// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "2024-08-02",
  platforms: [
    .macOS(.v14)
  ],
  targets: [
    .executableTarget(
      name: "2024-08-02",
      resources: [
        .process("../Resources/Info.plist")
      ],
      linkerSettings: [
        .unsafeFlags([
          "-Xlinker", "-sectcreate",
          "-Xlinker", "__TEXT",
          "-Xlinker", "__info_plist",
          "-Xlinker", "./Resources/Info.plist",
        ])
      ]
    ),
  ]
)
