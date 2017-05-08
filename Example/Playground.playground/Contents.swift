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

let view = UIView(frame: CGRect(x: 0, y: 100, width: 400, height: 712))
PlaygroundPage.current.liveView = view

view.backgroundColor = .white

let canvas =
k<UIView>.make {
    $0.view.backgroundColor = .lightGray }.add { r in
        
        k<UILabel>.make {
            $0.id = "topLabel"
            $0.view.text = "Hello"
            $0.centerInParent()
        }/r
        
        k<UIButton>.make {
            $0.id = "button"
            $0.view.setTitle("afasfsdsdbc", for: .normal)
            $0.under("topLabel", offset: 30)
            $0.centerHorizontallyInParent()
        }/r
}


class Cont: UIViewController, Controller {
    
    var root: AnyCanvas!
    var views: [String : UIView] = [:]
    
    override func loadView() {
        super.loadView()
        setContentView(with: canvas)
    }
    
    func didRender() {
        let but = get("button", UIButton.self).first
        but?.addTarget(self,
                       action: #selector(didSelect),
                       for: .touchUpInside)
    }
    
    func didSelect() {
        print("Did")
    }
    
}

let controller = Cont()
let contView = controller.view!

view.addSubview(contView)
contView.snp.makeConstraints { make in
    make.leading.trailing.top.bottom.equalToSuperview()
}