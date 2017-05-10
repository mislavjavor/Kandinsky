//
//  AnyCanvas.swift
//  Kandinsky
//
//  Created by Mislav Javor on 08/05/2017.
//
//

import Foundation
import UIKit

public class AnyCanvas : Canvas {
    
    required public init() {
        fatalError("Cannot use default instantiation with AnyCanvas. AnyCanvas is a type erasure wrapper")
    }
    
    init<T: Canvas>(_ canvas: T) {
        self.children = canvas.children
        self.view = canvas.view
        self.id = canvas.id
        self.deferToAfterRender = canvas.deferToAfterRender
    }
    
    public var deferToAfterRender: [ControllerInjectedHandler]
    
    public var children: [AnyCanvas]
    
    public var view: UIView
    
    public var id: String?
    
}
