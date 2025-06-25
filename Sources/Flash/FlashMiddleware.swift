/// The Flash middleware protocol.
public protocol FlashMiddleware: Sendable {
    /// Intercepts a request, processes it, and returns a new request.
    func interceptRequest(_ request: FlashRequest) async throws -> FlashRequest

    /// Intercepts a response, processes it, and returns a new response (can decide whether to retry
    /// based on the response).
    func interceptResponse(
        _ response: FlashResponse,
        retry: () async throws -> FlashResponse
    ) async throws -> FlashResponse
}

extension FlashMiddleware {
    /// The default implementation for intercepting a request, which directly returns the incoming
    /// request.
    public func interceptRequest(_ request: FlashRequest) async throws -> FlashRequest {
        request
    }

    /// The default implementation for intercepting a response, which directly returns the incoming
    /// response.
    public func interceptResponse(
        _ response: FlashResponse,
        retry: () async throws -> FlashResponse
    ) async throws -> FlashResponse {
        response
    }
}
