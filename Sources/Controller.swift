import UIKit

public typealias ViewHolder = [String: UIView]

public protocol Controller: class {

        
    func didRender(views: ViewHolder, root: AnyCanvas)
    
}


extension Controller {
    func executeDefferedAfterRenderActions<T: Canvas>(canvas: T, views: ViewHolder) {
        
        func r_pass_execute(_ canvas: AnyCanvas) {
            canvas.deferToAfterRender.forEach { $0(views) }
            canvas.children.forEach { r_pass_execute($0) }
        }
        r_pass_execute(canvas.eraseType())
        
    }
}








