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
    
    private let _didRenderFunc: (ViewHolder, AnyCanvas) -> ()
    
    public func didRender(views: ViewHolder, root: AnyCanvas) {
        _didRenderFunc(views, root)
    }
    
    init<T: Controller>(_ controller: T) {
        self._didRenderFunc = controller.didRender(views:root:)
    }
    
}
