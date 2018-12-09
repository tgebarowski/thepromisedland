import Foundation

extension Encodable {
    var jsonString: String {
        guard let jsonData = try? JSONEncoder().encode(self),
            let jsonString = String(data: jsonData, encoding: .utf8) else {
                return ""
        }
        return jsonString
    }

    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension Decodable {

    init(dictionary: [String: Any]) throws {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        let jsonDecoder = JSONDecoder()
        self = try jsonDecoder.decode(Self.self, from: data)
    }

    init(inputJSON: Data) throws {
        let jsonDecoder = JSONDecoder()
        self = try jsonDecoder.decode(Self.self, from: inputJSON)
    }
}
