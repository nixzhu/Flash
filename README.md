[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fnixzhu%2FFlash%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/nixzhu/Flash)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fnixzhu%2FFlash%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/nixzhu/Flash)

# Flash

A modern, Swift-native HTTP client library with middleware support and built-in retry mechanisms. Flash provides a clean, async/await-based API for making HTTP requests with powerful customization options.

## Features

- 🚀 **Modern Swift**: Built with async/await and `Sendable` support
- 🔧 **Middleware System**: Intercept and modify requests/responses with custom middleware
- 🔄 **Retry Policies**: Built-in support for fixed delay and exponential backoff retry strategies
- 📝 **Type-Safe**: Strongly-typed request builders with compile-time safety
- 🎯 **Lightweight**: Minimal dependencies, built on top of `URLSession`
- 🔍 **Flexible**: Support for GET, POST and PATCH requests with JSON body handling

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift`compiler.

Once your Swift package is set up, add Flash as a dependency to the `dependencies` value in your `Package.swift` file or to the package list in Xcode.

```swift
dependencies: [
    .package(url: "https://github.com/nixzhu/Flash.git", from: "0.1.0"),
]
```

Typically, you will want to depend on the `Flash` target:

```swift
.product(name: "Flash", package: "Flash")
```
