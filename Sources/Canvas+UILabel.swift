//
//  KandinskyUILabel.swift
//  Kandinsky
//
//  Created by Mislav Javor on 08/05/2017.
//  Copyright © 2017 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit

extension Canvas where UIKitRepresentation: UILabel {
    
    var fontFamily: String {
        get {
            return view.font.familyName
        }
        set {
            let currentFontSize = view.font.pointSize
            view.font = UIFont(name: newValue, size: currentFontSize)
        }
    }
    
    var fontSize: CGFloat {
        get {
            return view.font.pointSize
        }
        set {
            let currentFontFamily = view.font.familyName
            view.font = UIFont(name: currentFontFamily, size: newValue)
        }
    }
    
}
