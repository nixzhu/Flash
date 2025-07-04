import Foundation
import Testing
import Flash

struct HeaderMiddleware: FlashMiddleware {
    let name: String
    let value: String

    func interceptRequest(_ request: FlashRequest) async throws -> FlashRequest {
        var request = request

        request.headerFields.append(
            .init(
                name: name,
                value: value
            )
        )

        return request
    }
}

extension FlashClient {
    static let test = FlashClient(
        middlewares: [
            HeaderMiddleware(
                name: "X-Tester",
                value: "Nix"
            ),
        ]
    )
}

@Test func get() async throws {
    let request = FlashRequest.get(
        host: "httpbin.org",
        path: "/get"
    )

    let response = try await FlashClient.test.send(request)
    #expect(response.statusCode == 200)

    struct Output: Decodable {
        let headers: [String: String]
    }

    let output = try JSONDecoder().decode(Output.self, from: response.body)
    #expect(output.headers["X-Tester"] == "Nix")
}

@Test func post() async throws {
    do {
        let request = try FlashRequest.post(
            host: "httpbin.org",
            path: "/post",
            jsonBody: [
                "name": "Nix",
                "age": 18,
                "planet": "Earth",
            ]
        )

        let response = try await FlashClient.test.send(request)
        #expect(response.statusCode == 200)

        struct Output: Decodable {
            struct JSON: Decodable {
                let name: String
                let age: Int
                let planet: String
            }

            let headers: [String: String]
            let json: JSON
        }

        let output = try JSONDecoder().decode(Output.self, from: response.body)
        #expect(output.headers["X-Tester"] == "Nix")
        #expect(output.json.name == "Nix")
        #expect(output.json.age == 18)
        #expect(output.json.planet == "Earth")
    }

    do {
        let request = try FlashRequest.post(
            host: "httpbin.org",
            path: "/post",
            jsonBody: [
                [
                    "name": "Alice",
                    "age": 28,
                ],
                [
                    "name": "Bob",
                    "age": 32,
                ],
            ]
        )

        let response = try await FlashClient.test.send(request)
        #expect(response.statusCode == 200)

        struct Output: Decodable {
            struct JSON: Decodable {
                let name: String
                let age: Int
            }

            let headers: [String: String]
            let json: [JSON]
        }

        let output = try JSONDecoder().decode(Output.self, from: response.body)
        #expect(output.headers["X-Tester"] == "Nix")
        #expect(output.json[0].name == "Alice")
        #expect(output.json[0].age == 28)
        #expect(output.json[1].name == "Bob")
        #expect(output.json[1].age == 32)
    }
}

@Test func put() async throws {
    do {
        let request = try FlashRequest.put(
            host: "httpbin.org",
            path: "/put",
            jsonBody: [
                "name": "Nix",
                "age": 38,
                "planet": "Earth",
            ]
        )

        let response = try await FlashClient.test.send(request)
        #expect(response.statusCode == 200)

        struct Output: Decodable {
            struct JSON: Decodable {
                let name: String
                let age: Int
                let planet: String
            }

            let headers: [String: String]
            let json: JSON
        }

        let output = try JSONDecoder().decode(Output.self, from: response.body)
        #expect(output.headers["X-Tester"] == "Nix")
        #expect(output.json.name == "Nix")
        #expect(output.json.age == 38)
        #expect(output.json.planet == "Earth")
    }

    do {
        let request = try FlashRequest.put(
            host: "httpbin.org",
            path: "/put",
            jsonBody: [
                [
                    "name": "Alice",
                    "age": 28,
                ],
                [
                    "name": "Bob",
                    "age": 32,
                ],
            ]
        )

        let response = try await FlashClient.test.send(request)
        #expect(response.statusCode == 200)

        struct Output: Decodable {
            struct JSON: Decodable {
                let name: String
                let age: Int
            }

            let headers: [String: String]
            let json: [JSON]
        }

        let output = try JSONDecoder().decode(Output.self, from: response.body)
        #expect(output.headers["X-Tester"] == "Nix")
        #expect(output.json[0].name == "Alice")
        #expect(output.json[0].age == 28)
        #expect(output.json[1].name == "Bob")
        #expect(output.json[1].age == 32)
    }
}

@Test func patch() async throws {
    do {
        let request = try FlashRequest.patch(
            host: "httpbin.org",
            path: "/patch",
            jsonBody: [
                "planet": "Earth",
            ]
        )

        let response = try await FlashClient.test.send(request)
        #expect(response.statusCode == 200)

        struct Output: Decodable {
            struct JSON: Decodable {
                let planet: String
            }

            let headers: [String: String]
            let json: JSON
        }

        let output = try JSONDecoder().decode(Output.self, from: response.body)
        #expect(output.headers["X-Tester"] == "Nix")
        #expect(output.json.planet == "Earth")
    }

    do {
        let request = try FlashRequest.patch(
            host: "httpbin.org",
            path: "/patch",
            jsonBody: [
                [
                    "planet": "Earth",
                ],
                [
                    "planet": "Mars",
                ],
            ]
        )

        let response = try await FlashClient.test.send(request)
        #expect(response.statusCode == 200)

        struct Output: Decodable {
            struct JSON: Decodable {
                let planet: String
            }

            let headers: [String: String]
            let json: [JSON]
        }

        let output = try JSONDecoder().decode(Output.self, from: response.body)
        #expect(output.headers["X-Tester"] == "Nix")
        #expect(output.json[0].planet == "Earth")
        #expect(output.json[1].planet == "Mars")
    }
}

@Test func delete() async throws {
    let request = FlashRequest.delete(
        host: "httpbin.org",
        path: "/delete"
    )

    let response = try await FlashClient.test.send(request)
    #expect(response.statusCode == 200)
}
