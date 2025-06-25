import Foundation

/// A Flash response.
public struct FlashResponse: Sendable {
    /// The request.
    public var request: FlashRequest

    /// The HTTP status code.
    public var statusCode: Int

    /// An array of header fields.
    public var headerFields: [FlashHeaderField]

    /// The response body data.
    public var body: Data

    /// Initializes a new response.
    /// - Parameters:
    ///   - request: The request.
    ///   - statusCode: The HTTP status code.
    ///   - headerFields: An array of header fields.
    ///   - body: The response body data.
    public init(
        request: FlashRequest,
        statusCode: Int,
        headerFields: [FlashHeaderField],
        body: Data
    ) {
        self.request = request
        self.statusCode = statusCode
        self.headerFields = headerFields
        self.body = body
    }
}
