import PackageDescription

let package = Package(
    name: "LiveShowServer",
    targets: [
    	Target(name: "LiveShowServer")
    ],
	dependencies: [
		.Package(url: "https://github.com/IBM-Swift/HeliumLogger.git",       majorVersion: 1, minor: 3),
		.Package(url: "https://github.com/IBM-Swift/Kitura.git",             majorVersion: 1, minor: 3),
		.Package(url: "https://github.com/IBM-Swift/Swift-Kuery-PostgreSQL", majorVersion: 0, minor: 4),
		.Package(url: "https://github.com/davidungar/miniPromiseKit",        majorVersion: 4, minor: 2),
        .Package(url: "https://github.com/IBM-Swift/Kitura-Request.git", majorVersion: 0),
	]
)
