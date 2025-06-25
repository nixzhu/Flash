import Testing
@testable import Flash

@Test func get() async throws {
    let client = FlashClient()
    let request = FlashRequest.get(host: "echo.free.beeceptor.com", path: "/get")
    let response = try await client.send(request)
    #expect(response.statusCode == 200)
}
