
import UIKit

extension UIViewController {
    func addBehaviour(viewController: UIViewController) {
        addChild(viewController)
        viewController.view.alpha = 0
        view.addExpanded(subview: viewController.view)
        viewController.didMove(toParent: self)
    }

    func dispatch<T: UIViewController>(closure: (T) -> Void) {
        guard let callee: T = behaviour() else { return }
        closure(callee)
    }

    private func behaviour<T: UIViewController>() -> T? {
        return children.first(where: { $0 is T}) as? T
    }
}

private extension UIView {

    func expand(subview view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    func addExpanded(subview view: UIView) {
        self.addSubview(view)
        self.expand(subview: view)
    }
}
