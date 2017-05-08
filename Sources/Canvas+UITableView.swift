//
//  TVExtensions.swift
//  Kandinsky
//
//  Created by Mislav Javor on 02/05/2017.
//  Copyright © 2017 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit

public extension Canvas where UIKitRepresentation == UITableView {
    
    public var delegate: UITableViewDelegate? {
        get {
            return view.delegate
        }
        set {
            view.delegate = newValue
        }
    }
    
    public var dataSource: UITableViewDataSource? {
        get {
            return view.dataSource
        }
        set {
            view.dataSource = newValue
        }
    }
    
    public func setDelegateAndDataSource<T: UITableViewDelegate & UITableViewDataSource>(_ item: T) {
        self.delegate = item
        self.dataSource = item
    }
    
}
