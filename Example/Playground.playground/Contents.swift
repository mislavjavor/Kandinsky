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


let demoCanvas =
UIView.set {
    $0.view.backgroundColor = .white }.add { r in
        
        UIView.set {
            $0.id = "topView"
            $0.view.backgroundColor = .lightGray
            $0.alignParentTop()
            $0.alignParentLeading()
            $0.alignParentTrailing()
            $0.matchHeightToParent(dividedBy: 2)}.add { n in
                
                UILabel.set {
                    $0.id = "titleLabel"
                    $0.view.text = "Kandinsky Layout"
                    $0.fontSize = 35
                    $0.fontFamily = "AvenirNext-Medium"
                    $0.view.textColor = .red
                    $0.centerInParent()
                }/n
                
                UILabel.set {
                    $0.id = "subtitle"
                    $0.view.text = "Swift powered layouting engine"
                    $0.fontSize = 20
                    $0.view.textColor = .darkGray
                    $0.centerHorizontallyInParent()
                    $0.under("titleLabel", offset: 20)
                }/n
                
                UILabel.set {
                    $0.view.text = "hello world"
                    $0.centerHorizontallyInParent()
                    $0.under("subtitle")
                }/n
                
        }/r
        
        UIView.set {
            $0.id = "bottomView"
            $0.view.backgroundColor = .black
            $0.under("topView")
            $0.alignParentLeading()
            $0.alignParentTrailing()
            $0.alignParentBottom()}.add { n in
                
                UIButton.set {
                    $0.id = "pressMeButton"
                    $0.view.setTitle("Press me!", for: .normal)
                    $0.view.setTitleColor(.white, for: .normal)
                    $0.centerInParent()
                }/n
        }/r
}



class DemoVC: UIViewController, Controller {
    
    var views: ViewHolder = [:]
    
    override func loadView() {
        super.loadView()
        setContentView(with: demoCanvas)
    }
    
    func didRender(views: ViewHolder, root: AnyCanvas) {
        self.views = views
        let button = views["pressMeButton"] as? UIButton
        button?.addTarget(self, action: #selector(didTouchButton), for: .touchUpInside)
    }
    
    func didTouchButton() {
        let title = views["titleLabel"] as? UILabel
        title?.text = "Pressed the button"
        PlaygroundHelper.alert(over: self, message: "Pressed the button")
    }
}

let vc = DemoVC()
let view = PlaygroundHelper.embed(in: vc)
view.backgroundColor = .white
PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true



