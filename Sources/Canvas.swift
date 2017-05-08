//
//  Canvas.swift
//  Kandinsky
//
//  Created by Mislav Javor on 26/04/2017.
//  Copyright © 2017 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit

public typealias ControllerInjectedHandler = (AnyController) -> ()

public protocol Canvas: class {
    
    var deferToAfterRender: [ControllerInjectedHandler] { get set }
    
    associatedtype UIKitRepresentation: UIView
    
    var view: UIKitRepresentation { get }
        
    var children: [AnyCanvas] { get set }
    
    var id: String? { get set }
    
    init()
}

extension Canvas {
    
    func eraseType() -> AnyCanvas {
        return AnyCanvas(self)
    }
    
    
    func insert<T: Canvas>(into canvas: inout T) {
        canvas.children.append(AnyCanvas(self))
    }
    
    public typealias Creator = (inout Self) -> Void
    
    public static func make(_ maker: Creator) -> Self {
        var this = Self()
        maker(&this)
        return this
    }

    public typealias Maker = (inout Self) -> Void
    public func add(_ maker: Maker) -> Self {
        var this = self
        maker(&this)
        return this
    }
}

//extension Array where Element: Canvas {
//    public typealias Customizer = (inout Element) -> Void
//    public mutating func customize(_ customizer: Customizer) {
//        for i in 0..<self.count {
//            customizer(&self[i])
//        }
//    }
//}
