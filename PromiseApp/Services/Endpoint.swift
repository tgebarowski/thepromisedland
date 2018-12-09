import Foundation

enum Endpoint {

    case user(id: String)

    private var baseURL : String {
        return "https://api.github.com/users"
    }

    public var url : URL {
        switch self {
        case .user(let id):
            return URL(string: "\(baseURL)/\(id)")!
        }
    }
}

extension Endpoint: CustomStringConvertible {
    var description: String {
        return url.absoluteString
    }
}
