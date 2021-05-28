// swift-tools-version:5.0

import PackageDescription

let package = Package(
	name: "PrincipleAnimation",
	platforms: [
		.iOS(.v10),
	],
	products: [
		.library(name: "PrincipleAnimation", targets: ["PrincipleAnimation"]),
	],
	targets: [
		.target(name: "PrincipleAnimation", path: "PrincipleAnimation/Classes"),
	],
	swiftLanguageVersions: [
		.v5
	]
)
