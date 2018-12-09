import Foundation

protocol RequestBehaviour {
    func beforeSend()
    func afterSuccess(result: Any)
    func afterFailure(error: Error)
}

extension RequestBehaviour {
    func beforeSend() {}
    func afterSuccess(result: Any) {}
    func afterFailure(error: Error) {}
}

struct EmptyRequestBehavior: RequestBehaviour { }

struct CombinedRequestBehavior: RequestBehaviour {

    let behaviours: [RequestBehaviour]

    func beforeSend() {
        behaviours.forEach({ $0.beforeSend() })
    }

    func afterSuccess(result: Any) {
        behaviours.forEach({ $0.afterSuccess(result: result) })
    }

    func afterFailure(error: Error) {
        behaviours.forEach({ $0.afterFailure(error: error) })
    }
}
