import Foundation

/// A Flash request.
public struct FlashRequest: Sendable {
    /// The request method.
    public var method: Method

    /// The scheme.
    public var scheme: String

    /// The host.
    public var host: String

    /// The path.
    public var path: String

    /// The query dictionary.
    public var queries: QueryDictionary

    /// The array of header fields.
    public var headerFields: [FlashHeaderField]

    /// The body data.
    public var body: Data?

    /// The timeout interval.
    public var timeoutInterval: TimeInterval

    /// The retry policy.
    public var retryPolicy: RetryPolicy?

    /// Initializes a new request.
    /// - Parameters:
    ///   - method: The request method.
    ///   - scheme: The scheme.
    ///   - host: The host.
    ///   - path: The path.
    ///   - queries: The query dictionary.
    ///   - headerFields: The array of header fields.
    ///   - body: The body data (optional).
    ///   - timeoutInterval: The timeout interval in seconds (> 0).
    ///   - retryPolicy: The retry policy (optional).
    private init(
        method: Method,
        scheme: String,
        host: String,
        path: String,
        queries: QueryDictionary,
        headerFields: [FlashHeaderField],
        body: Data?,
        timeoutInterval: TimeInterval,
        retryPolicy: RetryPolicy?
    ) {
        self.method = method
        self.scheme = scheme
        self.host = host
        self.path = path
        self.queries = queries
        self.headerFields = headerFields
        self.body = body
        self.timeoutInterval = timeoutInterval
        self.retryPolicy = retryPolicy

        assert(timeoutInterval > 0)

        if let retryPolicy {
            switch retryPolicy {
            case .delay(let unit, let count, let maxCount):
                assert(unit > 0)
                assert(count >= 0)
                assert(maxCount >= count)
            case .exponentialDelay(let unit, let count, let maxCount):
                assert(unit > 0)
                assert(count >= 0)
                assert(maxCount >= count)
            }
        }
    }
}

extension FlashRequest {
    /// Creates a GET request.
    /// - Parameters:
    ///   - scheme: The scheme (default is `https`).
    ///   - host: The host.
    ///   - path: The path.
    ///   - queries: The query dictionary (default is `[:]`).
    ///   - headerFields: The array of header fields (default is `[]`).
    ///   - timeoutInterval: The timeout interval in seconds (default is `15`).
    ///   - retryPolicy: The retry policy (default is `nil`).
    /// - Returns: A `FlashRequest` instance.
    public static func get(
        scheme: String = "https",
        host: String,
        path: String,
        queries: QueryDictionary = [:],
        headerFields: [FlashHeaderField] = [],
        timeoutInterval: TimeInterval = 15,
        retryPolicy: RetryPolicy? = nil
    ) -> Self {
        .init(
            method: .get,
            scheme: scheme,
            host: host,
            path: path,
            queries: queries,
            headerFields: headerFields,
            body: nil,
            timeoutInterval: timeoutInterval,
            retryPolicy: retryPolicy
        )
    }

    /// Creates a POST request.
    /// - Parameters:
    ///   - scheme: The scheme (default is `https`).
    ///   - host: The host.
    ///   - path: The path.
    ///   - queries: The query dictionary (default is `[:]`).
    ///   - headerFields: The array of header fields (default is `[]`).
    ///   - jsonBody: The JSON body dictionary (optional, default is `nil`).
    ///   - timeoutInterval: The timeout interval in seconds (default is `15`).
    ///   - retryPolicy: The retry policy (default is `nil`).
    /// - Returns: A `FlashRequest` instance.
    public static func post(
        scheme: String = "https",
        host: String,
        path: String,
        queries: QueryDictionary = [:],
        headerFields: [FlashHeaderField] = [],
        jsonBody: JSONBodyDictionary? = nil,
        timeoutInterval: TimeInterval = 15,
        retryPolicy: RetryPolicy? = nil
    ) throws -> Self {
        try .init(
            method: .post,
            scheme: scheme,
            host: host,
            path: path,
            queries: queries,
            headerFields: headerFields + [
                .init(name: "Content-Type", value: "application/json"),
            ],
            body: jsonBody.flatMap { try JSONSerialization.data(withJSONObject: $0.dictionary) },
            timeoutInterval: timeoutInterval,
            retryPolicy: retryPolicy
        )
    }

    /// Creates a POST request.
    /// - Parameters:
    ///   - scheme: The scheme (default is `https`).
    ///   - host: The host.
    ///   - path: The path.
    ///   - queries: The query dictionary (default is `[:]`).
    ///   - headerFields: The array of header fields (default is `[]`).
    ///   - jsonBody: The JSON body array (optional, default is `nil`).
    ///   - timeoutInterval: The timeout interval in seconds (default is `15`).
    ///   - retryPolicy: The retry policy (default is `nil`).
    /// - Returns: A `FlashRequest` instance.
    public static func post(
        scheme: String = "https",
        host: String,
        path: String,
        queries: QueryDictionary = [:],
        headerFields: [FlashHeaderField] = [],
        jsonBody: JSONBodyArray? = nil,
        timeoutInterval: TimeInterval = 15,
        retryPolicy: RetryPolicy? = nil
    ) throws -> Self {
        try .init(
            method: .post,
            scheme: scheme,
            host: host,
            path: path,
            queries: queries,
            headerFields: headerFields + [
                .init(name: "Content-Type", value: "application/json"),
            ],
            body: jsonBody.flatMap { try JSONSerialization.data(withJSONObject: $0.array) },
            timeoutInterval: timeoutInterval,
            retryPolicy: retryPolicy
        )
    }

    /// Creates a PUT request.
    /// - Parameters:
    ///   - scheme: The scheme (default is `https`).
    ///   - host: The host.
    ///   - path: The path.
    ///   - queries: The query dictionary (default is `[:]`).
    ///   - headerFields: The array of header fields (default is `[]`).
    ///   - jsonBody: The JSON body dictionary (optional, default is `nil`).
    ///   - timeoutInterval: The timeout interval in seconds (default is `15`).
    ///   - retryPolicy: The retry policy (default is `nil`).
    /// - Returns: A `FlashRequest` instance.
    public static func put(
        scheme: String = "https",
        host: String,
        path: String,
        queries: QueryDictionary = [:],
        headerFields: [FlashHeaderField] = [],
        jsonBody: JSONBodyDictionary? = nil,
        timeoutInterval: TimeInterval = 15,
        retryPolicy: RetryPolicy? = nil
    ) throws -> Self {
        try .init(
            method: .put,
            scheme: scheme,
            host: host,
            path: path,
            queries: queries,
            headerFields: headerFields + [
                .init(name: "Content-Type", value: "application/json"),
            ],
            body: jsonBody.flatMap { try JSONSerialization.data(withJSONObject: $0.dictionary) },
            timeoutInterval: timeoutInterval,
            retryPolicy: retryPolicy
        )
    }

    /// Creates a PUT request.
    /// - Parameters:
    ///   - scheme: The scheme (default is `https`).
    ///   - host: The host.
    ///   - path: The path.
    ///   - queries: The query dictionary (default is `[:]`).
    ///   - headerFields: The array of header fields (default is `[]`).
    ///   - jsonBody: The JSON body array (optional, default is `nil`).
    ///   - timeoutInterval: The timeout interval in seconds (default is `15`).
    ///   - retryPolicy: The retry policy (default is `nil`).
    /// - Returns: A `FlashRequest` instance.
    public static func put(
        scheme: String = "https",
        host: String,
        path: String,
        queries: QueryDictionary = [:],
        headerFields: [FlashHeaderField] = [],
        jsonBody: JSONBodyArray? = nil,
        timeoutInterval: TimeInterval = 15,
        retryPolicy: RetryPolicy? = nil
    ) throws -> Self {
        try .init(
            method: .put,
            scheme: scheme,
            host: host,
            path: path,
            queries: queries,
            headerFields: headerFields + [
                .init(name: "Content-Type", value: "application/json"),
            ],
            body: jsonBody.flatMap { try JSONSerialization.data(withJSONObject: $0.array) },
            timeoutInterval: timeoutInterval,
            retryPolicy: retryPolicy
        )
    }

    /// Creates a PATCH request.
    /// - Parameters:
    ///   - scheme: The scheme (default is `https`).
    ///   - host: The host.
    ///   - path: The path.
    ///   - queries: The query dictionary (default is `[:]`).
    ///   - headerFields: The array of header fields (default is `[]`).
    ///   - jsonBody: The JSON body dictionary (optional, default is `nil`).
    ///   - timeoutInterval: The timeout interval in seconds (default is `15`).
    ///   - retryPolicy: The retry policy (default is `nil`).
    /// - Returns: A `FlashRequest` instance.
    public static func patch(
        scheme: String = "https",
        host: String,
        path: String,
        queries: QueryDictionary = [:],
        headerFields: [FlashHeaderField] = [],
        jsonBody: JSONBodyDictionary? = nil,
        timeoutInterval: TimeInterval = 15,
        retryPolicy: RetryPolicy? = nil
    ) throws -> Self {
        try .init(
            method: .patch,
            scheme: scheme,
            host: host,
            path: path,
            queries: queries,
            headerFields: headerFields + [
                .init(name: "Content-Type", value: "application/json"),
            ],
            body: jsonBody.flatMap { try JSONSerialization.data(withJSONObject: $0.dictionary) },
            timeoutInterval: timeoutInterval,
            retryPolicy: retryPolicy
        )
    }

    /// Creates a PATCH request.
    /// - Parameters:
    ///   - scheme: The scheme (default is `https`).
    ///   - host: The host.
    ///   - path: The path.
    ///   - queries: The query dictionary (default is `[:]`).
    ///   - headerFields: The array of header fields (default is `[]`).
    ///   - jsonBody: The JSON body array (optional, default is `nil`).
    ///   - timeoutInterval: The timeout interval in seconds (default is `15`).
    ///   - retryPolicy: The retry policy (default is `nil`).
    /// - Returns: A `FlashRequest` instance.
    public static func patch(
        scheme: String = "https",
        host: String,
        path: String,
        queries: QueryDictionary = [:],
        headerFields: [FlashHeaderField] = [],
        jsonBody: JSONBodyArray? = nil,
        timeoutInterval: TimeInterval = 15,
        retryPolicy: RetryPolicy? = nil
    ) throws -> Self {
        try .init(
            method: .patch,
            scheme: scheme,
            host: host,
            path: path,
            queries: queries,
            headerFields: headerFields + [
                .init(name: "Content-Type", value: "application/json"),
            ],
            body: jsonBody.flatMap { try JSONSerialization.data(withJSONObject: $0.array) },
            timeoutInterval: timeoutInterval,
            retryPolicy: retryPolicy
        )
    }

    /// Creates a DELETE request.
    /// - Parameters:
    ///   - scheme: The scheme (default is `https`).
    ///   - host: The host.
    ///   - path: The path.
    ///   - queries: The query dictionary (default is `[:]`).
    ///   - headerFields: The array of header fields (default is `[]`).
    ///   - timeoutInterval: The timeout interval in seconds (default is `15`).
    ///   - retryPolicy: The retry policy (default is `nil`).
    /// - Returns: A `FlashRequest` instance.
    public static func delete(
        scheme: String = "https",
        host: String,
        path: String,
        queries: QueryDictionary = [:],
        headerFields: [FlashHeaderField] = [],
        timeoutInterval: TimeInterval = 15,
        retryPolicy: RetryPolicy? = nil
    ) -> Self {
        .init(
            method: .delete,
            scheme: scheme,
            host: host,
            path: path,
            queries: queries,
            headerFields: headerFields,
            body: nil,
            timeoutInterval: timeoutInterval,
            retryPolicy: retryPolicy
        )
    }
}

extension FlashRequest {
    /// The request method.
    public enum Method: String, Sendable {
        /// GET
        case get = "GET"

        /// POST
        case post = "POST"

        /// PUT
        case put = "PUT"

        /// PATCH
        case patch = "PATCH"

        /// DELETE
        case delete = "DELETE"
    }
}

extension FlashRequest {
    /// A query dictionary that filters out nil values.
    public struct QueryDictionary: ExpressibleByDictionaryLiteral, Sendable {
        public typealias Key = String
        public typealias Value = (any CustomStringConvertible & Sendable)?

        public var dictionary: [Key: any CustomStringConvertible & Sendable]

        public init(_ dictionary: [Key: Value]) {
            self.dictionary = dictionary.compactMapValues { $0 }
        }

        public init(dictionaryLiteral elements: (Key, Value)...) {
            dictionary = .init(
                uniqueKeysWithValues: elements.compactMap { key, value in
                    if let value {
                        (key, value)
                    } else {
                        nil
                    }
                }
            )
        }
    }
}

extension FlashRequest {
    /// A JSON body dictionary that filters out nil values.
    public struct JSONBodyDictionary: ExpressibleByDictionaryLiteral {
        public typealias Key = String
        public typealias Value = Any?

        public var dictionary: [Key: Any]

        public init(_ dictionary: [Key: Value]) {
            self.dictionary = dictionary.compactMapValues { $0 }
        }

        public init(dictionaryLiteral elements: (Key, Value)...) {
            dictionary = .init(
                uniqueKeysWithValues: elements.compactMap { key, value in
                    if let value {
                        (key, value)
                    } else {
                        nil
                    }
                }
            )
        }
    }

    /// A JSON body array that filters out nil values.
    public struct JSONBodyArray: ExpressibleByArrayLiteral {
        public typealias ArrayLiteralElement = Any?

        public var array: [Any]

        public init(_ array: [ArrayLiteralElement]) {
            self.array = array.compactMap { $0 }
        }

        public init(arrayLiteral elements: ArrayLiteralElement...) {
            array = elements.compactMap { $0 }
        }
    }
}

extension FlashRequest {
    /// The retry policy.
    public enum RetryPolicy: Sendable {
        /// Fixed delay (delay duration: `unit * count`).
        /// - unit: The time unit in seconds.
        /// - count: The number of retries performed.
        /// - maxCount: The maximum number of retries.
        case delay(unit: TimeInterval, count: Int, maxCount: Int)

        /// Exponential backoff (delay duration: `unit * 2^count`).
        /// - unit: The time unit in seconds.
        /// - count: The number of retries performed.
        /// - maxCount: The maximum number of retries.
        case exponentialDelay(unit: TimeInterval, count: Int, maxCount: Int)

        /// Standard retry policy (exponential delay, 2-second unit, max 3 retries).
        public static var standard: Self {
            .exponentialDelay(unit: 2, count: 0, maxCount: 3)
        }

        var nanoseconds: UInt64 {
            switch self {
            case .delay(let unit, let count, _):
                let seconds = unit * Double(count)
                return .init(seconds * 1_000_000_000)
            case .exponentialDelay(let unit, let count, _):
                let seconds = unit * pow(2, Double(count))
                return .init(seconds * 1_000_000_000)
            }
        }
    }
}

extension FlashRequest {
    var retryRequest: Self? {
        guard let retryPolicy else { return nil }

        switch retryPolicy {
        case .delay(let unit, let count, let maxCount):
            let newCount = count + 1

            if newCount <= maxCount {
                var request = self

                request.retryPolicy = .delay(
                    unit: unit,
                    count: newCount,
                    maxCount: maxCount
                )

                return request
            }
        case .exponentialDelay(let unit, let count, let maxCount):
            let newCount = count + 1

            if newCount <= maxCount {
                var request = self

                request.retryPolicy = .exponentialDelay(
                    unit: unit,
                    count: newCount,
                    maxCount: maxCount
                )

                return request
            }
        }

        return nil
    }

    var urlRequest: URLRequest {
        get throws {
            let url: URL = try {
                var urlComponents = URLComponents()
                urlComponents.scheme = scheme
                urlComponents.host = host
                urlComponents.path = path

                let queryItems: [URLQueryItem] = queries.dictionary
                    .sorted(by: { $0.key < $1.key })
                    .map { key, value in
                        .init(name: key, value: value.description)
                    }

                if !queryItems.isEmpty {
                    urlComponents.queryItems = queryItems
                }

                guard let url = urlComponents.url else {
                    throw URLError(.badURL)
                }

                return url
            }()

            var urlRequest: URLRequest = .init(url: url, timeoutInterval: timeoutInterval)
            urlRequest.httpMethod = method.rawValue

            for headerField in headerFields {
                urlRequest.addValue(headerField.value, forHTTPHeaderField: headerField.name)
            }

            switch method {
            case .get, .delete:
                assert(body == nil)
            case .post, .patch, .put:
                urlRequest.httpBody = body
            }

            return urlRequest
        }
    }
}
