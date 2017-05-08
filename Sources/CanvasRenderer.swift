//
//  CanvasRenderer.swift
//  Kandinsky
//
//  Created by Mislav Javor on 08/05/2017.
//
//

import Foundation

public struct CanvasRenderer { private init() {}
    
    public static func render<T: Canvas>(canvas: T) -> UIView {
        return p_render(canvas: canvas.eraseType())
    }
    
    private static func p_render(canvas: AnyCanvas) -> UIView {
        let selfView = canvas.view
        canvas.children.map { p_render(canvas: $0) }.forEach { selfView.addSubview($0) }
        return selfView
    }
    
}
