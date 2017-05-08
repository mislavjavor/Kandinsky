//
//  CanvasRepresentable.swift
//  Kandinsky
//
//  Created by Mislav Javor on 02/05/2017.
//  Copyright © 2017 Mislav Javor. All rights reserved.
//

import Foundation

public protocol CanvasRepresentable {
    
    associatedtype RootCanvasType: Canvas
    
    func asCanvas() -> RootCanvasType
}
