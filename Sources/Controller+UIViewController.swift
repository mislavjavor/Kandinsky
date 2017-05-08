//
//  Controller+UIViewController.swift
//  Kandinsky
//
//  Created by Mislav Javor on 08/05/2017.
//  Copyright © 2017 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit

extension Controller where Self: UIViewController {
    func setContentView<T: Canvas>(with canvas: T) {
        
        self.root = canvas.eraseType()
        
        func r_render(canvas: AnyCanvas) -> UIView {
            let selfView = canvas.view
            if let id = canvas.id {
                views[id] = selfView
            }
            canvas.children.map { r_render(canvas: $0) }.forEach { selfView.addSubview($0) }
            return selfView
        }
        let renderResult = r_render(canvas: root)
        self.view = renderResult
        didRender()
        executeDefferedAfterRenderActions()
    }
}

