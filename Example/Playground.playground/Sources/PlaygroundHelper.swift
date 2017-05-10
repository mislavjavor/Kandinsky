import Foundation
import UIKit
import Kandinsky
import SnapKit

public struct PlaygroundHelper { private init() {}
    
    public static func embed<T>(in viewController: T) -> UIView
                    where T: UIViewController, T: Controller {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 700))
        
        let controllerView = viewController.view!
        view.addSubview(controllerView)
        controllerView.snp.makeConstraints { make in
            make.leading.top.bottom.trailing.equalToSuperview()
        }
        return view
    }
    
    public static func alert(over viewController: UIViewController, message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
