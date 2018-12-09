import UIKit

protocol ActivityIndicatorProviding {
    func registerActivityIndicatorProvider()
    func showProgress()
    func hideProgress()
    func show(error: Error)
}

extension ActivityIndicatorProviding where Self: UIViewController {

    func registerActivityIndicatorProvider() {
        addBehaviour(viewController: ActivityIndicatorBehaviour())
    }

    func showProgress() {
        dispatch { (behaviour: ActivityIndicatorBehaviour) in
            behaviour.showProgressHud()
        }
    }

    func hideProgress() {
        dispatch { (behaviour: ActivityIndicatorBehaviour) in
            behaviour.hideProgressHud()
        }
    }

    func show(error: Error) {
        dispatch { (behaviour: ActivityIndicatorBehaviour) in
            behaviour.show(error: error)
        }
    }
}

final class ActivityIndicatorBehaviour: UIViewController, ActivityIndicatorProviding {

    let application = UIApplication.shared

    func showProgressHud() {
        application.isNetworkActivityIndicatorVisible = true
    }

    func hideProgressHud() {
        application.isNetworkActivityIndicatorVisible = false
    }

    func show(error: Error) {
        hideProgressHud()
        showAlertController(error: error)
    }

    private func showAlertController(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
