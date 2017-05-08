//
//  AnyCanvas.swift
//  Kandinsky
//
//  Created by Mislav Javor on 08/05/2017.
//
//

import Foundation

class AnyCanvas : Canvas {
    
    required init() {
        fatalError("Cannot use default instantiation with AnyCanvas. AnyCanvas is a type erasure wrapper")
    }
    
    init<T: Canvas>(_ canvas: T) {
        self.children = canvas.children
        self.view = canvas.view
        self.id = canvas.id
        self.deferToAfterRender = canvas.deferToAfterRender
    }
    
    var deferToAfterRender: [ControllerInjectedHandler]
    
    var children: [AnyCanvas]
    
    var view: UIView
    
    var id: String?
    
}
