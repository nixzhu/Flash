/// A header field for Flash (used for both requests and responses).
public struct FlashHeaderField: Sendable {
    /// The name of the header field.
    public var name: String

    /// The value of the header field.
    public var value: String

    /// Initializes a header field.
    /// - Parameters:
    ///   - name: The name of the header field.
    ///   - value: The value of the header field.
    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}