//
//  K.swift
//  Kandinsky
//
//  Created by Mislav Javor on 02/05/2017.
//  Copyright © 2017 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit

final class k<T: UIView> : Canvas {
    
    var deferToAfterRender: [ControllerInjectedHandler]
    
    var view: T
    
    var children: [AnyCanvas]
    
    var id: String?
    
    init() {
        deferToAfterRender = []
        view = T()
        children = []
    }
}

