//
//  AnyController.swift
//  Kandinsky
//
//  Created by Mislav Javor on 08/05/2017.
//  Copyright © 2017 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit

final class AnyController: Controller {
    
    var root: AnyCanvas!
    
    var views: [String : UIView]
    
    private let _didRenderFunc: () -> ()
    
    func didRender() {
        _didRenderFunc()
    }
    
    init<T: Controller>(_ controller: T) {
        self.root = controller.root
        self.views = controller.views
        self._didRenderFunc = {
            controller.didRender()
        }
    }
    
}
