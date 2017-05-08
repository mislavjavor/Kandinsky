//
//  K.swift
//  Kandinsky
//
//  Created by Mislav Javor on 02/05/2017.
//  Copyright © 2017 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit

public final class k<T: UIView> : Canvas {
    
    public var deferToAfterRender: [ControllerInjectedHandler]
    
    public var view: T
    
    public var children: [AnyCanvas]
    
    public var id: String?
    
    public init() {
        deferToAfterRender = []
        view = T()
        children = []
    }
}

