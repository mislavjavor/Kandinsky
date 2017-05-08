//
//  AnyController.swift
//  Kandinsky
//
//  Created by Mislav Javor on 08/05/2017.
//  Copyright © 2017 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit

public final class AnyController: Controller {
    
    public var root: AnyCanvas!
    
    public var views: [String : UIView]
    
    private let _didRenderFunc: () -> ()
    
    public func didRender() {
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
