//
//  CanvasRenderer.swift
//  Kandinsky
//
//  Created by Mislav Javor on 08/05/2017.
//
//

import Foundation
import UIKit

public struct CanvasRenderer { private init() {}
    
    public static func render<T: Canvas>(canvas: T) -> UIView {
        var viewHolder : ViewHolder = [:]
        let rendered = p_render(canvas: canvas.eraseType(), views: &viewHolder)
        r_runDeffered(canvas: canvas.eraseType(), viewHolder: &viewHolder)
        return rendered
    }
    
    private static func p_render(canvas: AnyCanvas, views: inout ViewHolder) -> UIView {
        let selfView = canvas.view
        if let id = canvas.id {
            views[id] = canvas.view
        }
        canvas.children.map { p_render(canvas: $0, views: &views) }
            .forEach { selfView.addSubview($0) }
        return selfView
    }
    
    private static func r_runDeffered(canvas: AnyCanvas, viewHolder: inout ViewHolder) {
        canvas.deferToAfterRender.forEach { $0(viewHolder) }
        canvas.children.forEach { r_runDeffered(canvas: $0, viewHolder: &viewHolder) }
    }
    
}
