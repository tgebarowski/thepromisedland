import UIKit

class DemoViewController: ViewController {

    lazy var repository: GithubRepository = {
        return GithubRepository(behaviour: behaviour)
    }()

    lazy var behaviour: RequestBehaviour = {
        return ActivityIndicatorRequestBehaviour(activityIndicatorProvider: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        repository.fetch(user: "tgebarowski").then {
            print("Fetched: \($0)")
        }
    }
}

extension DemoViewController: ActivityIndicatorProviding {}
