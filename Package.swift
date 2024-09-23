// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  // NB: Keep this for backwards compatibility. Will rename to 'swift-issue-reporting' in 2.0.
  name: "xctest-dynamic-overlay",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(name: "IssueReporting", targets: ["IssueReporting"]),
    .library(name: "IssueReportingTestSupport", targets: ["IssueReportingTestSupport"]),
  ],
  targets: [
    .target(
      name: "IssueReporting"
    ),
    .testTarget(
      name: "IssueReportingTests",
      dependencies: [
        "IssueReporting",
        "IssueReportingTestSupport",
      ]
    ),
    .target(
      name: "IssueReportingTestSupport"
    ),
    .testTarget(
      name: "XCTestDynamicOverlayTests",
      dependencies: [
        "IssueReportingTestSupport",
      ]
    ),
  ]
)

#if os(macOS)
  package.dependencies.append(contentsOf: [
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    .package(url: "https://github.com/swiftwasm/carton", from: "1.0.0"),
  ])
  package.targets.append(
    .executableTarget(
      name: "WasmTests",
      dependencies: [
        "IssueReporting"
      ]
    )
  )
#endif
