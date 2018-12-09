import Foundation

struct GithubUser: Codable {
    let login: String
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarUrl = "avatar_url"
    }
}

extension GithubUser: CustomStringConvertible {
    var description: String {
        return "GithubUser: \(login) \(avatarUrl)"
    }
}
