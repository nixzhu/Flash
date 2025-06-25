import Foundation

/// A Flash client.
public struct FlashClient: Sendable {
    private let session: URLSession
    private let middlewares: [FlashMiddleware]

    /// Initializes a new Flash client.
    /// - Parameters:
    ///   - session: The `URLSession` for network requests (default: `.shared`).
    ///   - middlewares: A list of middlewares to intercept requests or responses (default: `[]`).
    public init(
        session: URLSession = .shared,
        middlewares: [FlashMiddleware] = []
    ) {
        self.session = session
        self.middlewares = middlewares
    }

    /// Sends a request, asynchronously receives a response, or throws an error.
    public func send(_ initialRequest: FlashRequest) async throws -> FlashResponse {
        let request: FlashRequest = try await {
            var request = initialRequest

            for middleware in middlewares {
                request = try await middleware.interceptRequest(request)
            }

            return request
        }()

        do {
            let urlRequest = try request.urlRequest
            let (data, urlResponse) = try await session.data(for: urlRequest)

            guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }

            return try await {
                let headerFields: [FlashHeaderField] = httpURLResponse
                    .allHeaderFields
                    .compactMap { name, value in
                        guard let name = name as? String,
                              let value = value as? String
                        else {
                            assertionFailure("Invalid header field!")
                            return nil
                        }

                        return .init(name: name, value: value)
                    }

                var response = FlashResponse(
                    request: request,
                    statusCode: httpURLResponse.statusCode,
                    headerFields: headerFields,
                    body: data
                )

                for middleware in middlewares {
                    response = try await middleware.interceptResponse(
                        response,
                        retry: { try await send(initialRequest) }
                    )
                }

                return response
            }()
        } catch {
            if let newRequest = initialRequest.retryRequest,
               let retryPolicy = newRequest.retryPolicy
            {
                try await Task.sleep(nanoseconds: retryPolicy.nanoseconds)
                return try await send(newRequest)
            } else {
                throw error
            }
        }
    }
}
