//
//  Playground.playground
//  Kandinsky
//
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

//: Playground - noun: a place where people can play

import UIKit
import Kandinsky
import PlaygroundSupport


protocol CanvasExtender {
    
}

extension CanvasExtender where Self: UIView {
    
    typealias Maker = (inout Kandinsky<Self>) -> Void
    static func `do`(_ maker: Maker) -> Kandinsky<Self> {
        let wrapped = Kandinsky<Self>.self
        return wrapped.make(maker)
    }
    
    static var `do`: Kandinsky<Self> {
        return Kandinsky<Self>()
    }
}

extension UIView: CanvasExtender { }

let myTemplate =
UIView.do.add { r in
        
        UIButton.do {
            $0.id = "pushButton"
            $0.view.setTitle("Hello", for: .normal)
            $0.centerInParent()
        }/r
        
        UILabel.do {
            $0.id = "titleLabel"
            $0.view.text = "Kandinsky"
            $0.fontSize = 30
            $0.view.textColor = .white
            $0.under("pushButton", offset: 20)
            $0.centerHorizontallyInParent()
        }/r
}

class MyVC: UIViewController, Controller {
    
    override func loadView() {
        setContentView(with: myTemplate)
    }
    
    func didRender(views: ViewHolder, root: AnyCanvas) {
        
    }
    
}

let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 600))
view.backgroundColor = .white
let vc = MyVC()
view.addSubview(vc.view)
vc.view.snp.makeConstraints { make in
    make.leading.trailing.top.bottom.equalToSuperview()
}
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = view





