//
//  KandinskyUILabel.swift
//  Kandinsky
//
//  Created by Mislav Javor on 08/05/2017.
//  Copyright © 2017 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit

public extension Canvas where UIKitRepresentation: UILabel {
    
    public var fontFamily: String {
        get {
            return view.font.familyName
        }
        set {
            let currentFontSize = view.font.pointSize
            view.font = UIFont(name: newValue, size: currentFontSize)
        }
    }
    
    public var fontSize: CGFloat {
        get {
            return view.font.pointSize
        }
        set {
            let currentFontFamily = view.font.familyName
            view.font = UIFont(name: currentFontFamily, size: newValue)
        }
    }
    
}
