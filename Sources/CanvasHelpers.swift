//
//  Constrainable.swift
//  Kandinsky
//
//  Created by Mislav Javor on 28/04/2017.
//  Copyright © 2017 Mislav Javor. All rights reserved.
//

import Foundation
import SnapKit

extension Canvas {
    
    func alignParentTop(offset: Int = 0) {
        deferToAfterRender.append { _ in
            self.view.snp.makeConstraints { $0.top.equalToSuperview().offset(offset) }
        }
    }
    
    func alignParentTrailing() {
        deferToAfterRender.append {  _ in
            self.view.snp.makeConstraints { $0.trailing.equalToSuperview() }
        }
    }
    
    func alignParentLeading() {
        deferToAfterRender.append {  _ in
            self.view.snp.makeConstraints { $0.leading.equalToSuperview() }
        }
    }
    
    func alignParentBottom() {
        deferToAfterRender.append {  _ in
            self.view.snp.makeConstraints { $0.bottom.equalToSuperview() }
        }
    }
    
    func offset(_ top: Int, _ leading: Int, _ bottom: Int, _ trailing: Int) {
        deferToAfterRender.append {  _ in
            self.view.snp.makeConstraints { make in
                make.topMargin.equalTo(top)
                make.leadingMargin.equalTo(leading)
                make.trailingMargin.equalTo(trailing)
                make.bottomMargin.equalTo(bottom)
            }
        }
    }
    
    var height: UInt {
        get {
            return self.height
        }
        set {
            self.view.snp.makeConstraints { make in
                make.height.equalTo(height)
            }
        }
    }
    
    func toRightOf(_ view: String) {
        deferToAfterRender.append {  controller in
            guard
                let rightView = controller.views[view]
            else {
                fatalError("Failed to add view \(self.id ?? "unknown") 'toRightOf' view \(view)")
            }
            
            self.view.snp.makeConstraints { make in
                make.leading.equalTo(rightView.snp.trailing)
            }
        }
    }
    
    func toLeftOf(_ view: String) {
        deferToAfterRender.append {  controller in
            guard
                let leftView = controller.views[view]
            else {
                    fatalError("Failed to add view \(self.id ?? "unknown") 'toLeftOf' view \(view)")
            }
            
            self.view.snp.makeConstraints { make in
                make.trailing.equalTo(leftView.snp.leading)
            }
        }
    }
    
    func under(_ view: String, offset: Int = 0) {
        deferToAfterRender.append {  controller in
            guard
                let underView = controller.views[view]
                else {
                    fatalError("Failed to add view \(self.id ?? "unknown") 'under' view \(view)")
            }
            
            self.view.snp.makeConstraints { make in
                make.top.equalTo(underView.snp.bottom).offset(offset)
            }
        }
    }
    
    func above(_ view: String, offset: Int = 0) {
        deferToAfterRender.append {  controller in
            guard
                let overView = controller.views[view]
                else {
                    fatalError("Failed to add view \(self.id ?? "unknown") 'above' view \(view)")
            }
            
            self.view.snp.makeConstraints { make in
                make.bottom.equalTo(overView.snp.top).offset(offset)
            }
        }
    }
    
    func centerInParent(xOffset: Int = 0, yOffset: Int = 0) {
        deferToAfterRender.append {  _ in
            self.view.snp.makeConstraints {
                $0.centerX.equalToSuperview().offset(xOffset)
                $0.centerY.equalToSuperview().offset(yOffset)
            }
        }
    }
    
    func centerHorizontallyInParent() {
        deferToAfterRender.append { _ in
            self.view.snp.makeConstraints { $0.centerX.equalToSuperview() }
        }
    }
    
    func matchHeightToParent(dividedBy factor: Int) {
        deferToAfterRender.append { _ in
            self.view.snp.makeConstraints { make in
                make.height.equalToSuperview().dividedBy(factor)
            }
        }
    }
    
}














