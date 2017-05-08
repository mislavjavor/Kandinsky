import UIKit

protocol Controller: class {
    
    var root: AnyCanvas! { get set }
    
    var views: [String: UIView] { get set }
        
    func didRender()
    
}

extension Controller {
    
    func executeDefferedAfterRenderActions() {
        
        func r_pass_execute(_ canvas: AnyCanvas) {
            canvas.deferToAfterRender.forEach { $0(AnyController(self)) }
            canvas.children.forEach { r_pass_execute($0) }
        }
        r_pass_execute(self.root)
        
    }
    
    
    typealias Customizer<T: UIView> = (inout T) -> Void
    func q<T: UIView>(_ id: String, as type: T.Type? = nil, handler: @escaping Customizer<T>) {
        
        
        var results =
            r_find(id: id, type: type, in: root).map { $0.view }
                .map { $0 as? T }
                .flatMap { $0 }
        (0..<results.count).forEach { i in
            handler(&results[i])
        }
    }
    
    func get<T: UIView>(_ id: String, _ type: T.Type) -> [T] {
        return r_find(id: id, type: type, in: self.root).map { $0.view as? T}.flatMap { $0 }
    }
    
    private func r_find<T: UIView>(id: String, type: T.Type?, in canvas: AnyCanvas) -> [AnyCanvas] {
        
        let selfIsValid: [AnyCanvas]
        if canvas.view is T,
            canvas.id == id {
            selfIsValid = [canvas]
        } else {
            selfIsValid = []
        }
        return selfIsValid + canvas.children.map { r_find(id: id, type: type, in: $0) }.flatMap { $0 }
    }
}









