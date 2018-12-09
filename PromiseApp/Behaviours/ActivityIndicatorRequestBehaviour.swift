
import Foundation

class ActivityIndicatorRequestBehaviour: RequestBehaviour {

    private let activityIndicatorProvider: ActivityIndicatorProviding

    init(activityIndicatorProvider: ActivityIndicatorProviding) {
        self.activityIndicatorProvider = activityIndicatorProvider
    }

    func beforeSend() {
        activityIndicatorProvider.showProgress()
    }

    func afterSuccess(result: Any) {
        activityIndicatorProvider.hideProgress()
    }

    func afterFailure(error: Error) {
        activityIndicatorProvider.show(error: error)
    }
}
