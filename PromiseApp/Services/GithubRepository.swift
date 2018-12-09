import Foundation
import Promise

class GithubRepository: Repository {
    func fetch(user: String) -> Promise<GithubUser> {
        return get(url: Endpoint.user(id: user).url)
    }
}
