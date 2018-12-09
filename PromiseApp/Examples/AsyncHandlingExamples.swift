import Foundation
import Promise

// Examples demonstrating typical ways of handling asynchronous code in Swift

struct Model {
    let name: String = "Dummy"
}

// Example 1: two completion handlers, one for error, one for failure
class ServiceA {
    func send(completion: (Model) -> Void, error: (Error) -> Void) { /* TODO */ }
    func ack(model: Model, completion: () -> Void, error: (Error) -> Void) { /* TODO */}

    func trigger() {
        send(completion: { [weak self] (model) in
            self?.ack(model: model, completion: {
                /*TODO*/
            }, error: { (error) in
                /*TODO Error handling 🙄 */
            })
        }) { (error) in
            /*TODO Error handling 🙄 */
        }
    }

    private func showActivityIndicator() {}
    private func hideActivityIndicator() {}
    private func handle(error: Error) {}

    func download() {
        showActivityIndicator()
        send(completion: { [weak self] (model) in
            self?.hideActivityIndicator()
        }) { [weak self] (error) in
            self?.hideActivityIndicator()
            self?.handle(error: error)
        }
    }
}

// Example 2a Using Result type and completion handler
enum Result<Value> {
    case success(Value)
    case failure(Error)
}

class ServiceB {
    func send(completion: (Result<Model>) -> Void) {/* Implement me */}
    func ack(model: Model, completion: (Result<Model>) -> Void) {/* Implement me */}

    func trigger() {
        send { [weak self] (result) in
            switch result {
            case .success(let value):
                self?.ack(model: value, completion: { (result) in
                    switch result {
                    case .success(_): return /*TODO */
                    case .failure(_): return /*TODO error handling 🤫 */
                    }
                })
            case .failure(_):
                /* TODO Error handling */
                return
            }
        }
    }
}

// Example 2b: Using Result type and completion handler with extracted second handler
class ServiceC {

    func send(completion: (Result<Model>) -> Void) {/* Implement me */}

    func ack(model: Model, completion: (Result<Model>) -> Void) {/* Implement me */}

    func trigger() {
        send { [weak self] (result) in
            switch result {
            case .success(let value):
                self?.handleAck(model: value)
            case .failure(_):
                /* TODO Error handling */
                return
            }
        }
    }

    private func handleAck(model: Model) {
        ack(model: model, completion: { (result) in
            switch result {
            case .success(_): return /*TODO */
            case .failure(_): return /*TODO error handling 🤫 */
            }
        })
    }
}

// Example 3: Promises
class ServiceD {

    func send() -> Promise<Model> {
        /* Implement me */
        return Promise(value: Model())
    }

    func ack(model: Model) -> Promise<Void> {
        /* Implement me */
        return Promise()
    }

    func trigger() {
        send().then { [weak self] (model) in
            return self?.ack(model: model)
        }.then { (_) in
            /*TODO Implement success */
        }.catch { (error) in
            /* TODO Implement error handling 🤫 */
        }
    }
}
