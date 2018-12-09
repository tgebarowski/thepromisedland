import Foundation
import Promise

class Repository {

    private let behaviour: RequestBehaviour
    private let session: URLSession

    init(behaviour: CombinedRequestBehavior,
         session: URLSession = URLSession.shared) {
        self.behaviour = behaviour
        self.session = session
    }

    init(behaviour: RequestBehaviour = EmptyRequestBehavior(),
         session: URLSession = URLSession.shared) {
        self.behaviour = behaviour
        self.session = session
    }

    func get<T: Decodable>(url: URL) -> Promise<T> {
        return Promise<T>(work: { [weak self] (fulfill, reject) in
            DispatchQueue.main.async {
                self?.behaviour.beforeSend()
            }
            self?.session.dataTask(with: url) { [weak self] (data, response, error) in
                DispatchQueue.main.async {
                    if let theError = error {
                        self?.behaviour.afterFailure(error: theError)
                        reject(theError)
                    } else if let theData = data,
                        let model = try? T.init(inputJSON: theData) {
                        self?.behaviour.afterSuccess(result: model)
                        fulfill(model)
                    } else {
                        let genericError: Error = "Unknown error"
                        self?.behaviour.afterFailure(error: genericError)
                        reject(genericError)
                    }
                }
            }.resume()
        })
    }
}
