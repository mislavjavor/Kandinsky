//
//  CanvasUIKitUtility.swift
//  Kandinsky
//
//  Created by Mislav Javor on 10/05/2017.
//
//

import Foundation

public protocol CanvasExtender {
    
}

public extension CanvasExtender where Self: UIView {
    
    typealias Maker = (inout Kandinsky<Self>) -> Void
    public static func `set`(_ maker: Maker) -> Kandinsky<Self> {
        let wrapped = Kandinsky<Self>.self
        return wrapped.make(maker)
    }
    
    public static var `do`: Kandinsky<Self> {
        return Kandinsky<Self>()
    }
}

extension UIView: CanvasExtender { }
