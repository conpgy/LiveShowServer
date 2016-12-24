import PackageDescription

let package = Package(
    name: "LiveShowServer",
    targets: [
        Target(name: "Server", dependencies: [.Target(name: "LiveShow")]),
        Target(name: "LiveShow")
    ],

	dependencies: [
		.Package(url: "https://github.com/IBM-Swift/HeliumLogger.git",       majorVersion: 1, minor: 4),
		.Package(url: "https://github.com/IBM-Swift/Kitura.git",             majorVersion: 1, minor: 4),
		.Package(url: "https://github.com/IBM-Swift/Swift-Kuery-PostgreSQL", majorVersion: 0, minor: 4),
		.Package(url: "https://github.com/davidungar/miniPromiseKit",        majorVersion: 4, minor: 2),
        .Package(url: "https://github.com/IBM-Swift/Kitura-Request.git", majorVersion: 0),
        .Package(url: "https://github.com/IBM-Swift/Kitura-MustacheTemplateEngine.git", majorVersion: 1, minor: 4),
        .Package(url: "https://github.com/IBM-Swift/Kitura-StencilTemplateEngine.git", majorVersion: 1, minor: 4),
        .Package(url: "https://github.com/IBM-Swift/Kitura-Markdown", majorVersion: 0, minor: 6),
	]
)
