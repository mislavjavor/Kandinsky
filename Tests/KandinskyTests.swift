//
//  KandinskyTests.swift
//  KandinskyTests
//
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import XCTest
@testable import Kandinsky
import UIKit

class TestVC: UIViewController, Controller {
    
    var didRenderTriggered: (() -> Void)?
    
    let layout =
    UIView.set {
            $0.id = "testView"
            $0.view.backgroundColor = .red }.add { r in
                
                UIButton.set {
                    $0.id = "button"
                    $0.centerInParent()
                    }/r
                
                UILabel.set {
                    $0.id = "label"
                    $0.under("button")
                    $0.alignParentLeading()
                    $0.alignParentTrailing()
                    }/r
    }
    
    override func loadView() {
        super.loadView()
        setContentView(with: layout)
    }
    
    func didRender(views: ViewHolder, root: AnyCanvas) {
        
        didRenderTriggered?()
        
        guard
            let testView = views["testView"],
            let buttonView = views["button"],
            let labelView = views["label"]
        else {
            XCTFail("Couldn't get views")
            fatalError()
        }
        
        XCTAssertNotNil(buttonView as? UIButton)
        XCTAssertNotNil(labelView as? UILabel)
        XCTAssert(!testView.subviews.isEmpty)
    }
}


class KandinskyTests: XCTestCase {
    
    let layout =
    UIView.set {
        $0.id = "testView"
        $0.view.backgroundColor = .red }.add { r in
            
            UIButton.set {
                $0.id = "button"
                $0.centerInParent()
            }/r
            
            UILabel.set {
                $0.id = "label"
                $0.under("button")
                $0.alignParentLeading()
                $0.alignParentTrailing()
                $0.fontSize = 30
                $0.fontFamily = "AvenirNext-Medium"
            }/r
            
            UISwitch.set {
                $0.id = "switch"
                $0.alignParentTop()
                $0.alignParentBottom()
                $0.toLeftOf("label")
            }/r
    }
    
    override func setUp() {
        super.setUp()
       
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_createView() {
        let result = CanvasRenderer.render(canvas: layout)
        XCTAssertNotNil(result)
    }
    
    func test_addSubviews() {
        let result = CanvasRenderer.render(canvas: layout)
        let subviews = result.subviews
        XCTAssert(!subviews.isEmpty)
    }
    
    func test_setID() {
        let id = layout.id
        XCTAssertEqual(id, "testView")
        
        let buttonId = layout.children[0].id
        XCTAssertEqual(buttonId, "button")
    }
    
    func test_parentAlignment() {
        let result = CanvasRenderer.render(canvas: layout)
        let label = result.subviews[1]
        
        XCTAssert(!result.constraints.isEmpty)
        
        XCTAssert(result.constraints.contains {
            $0.constant == 0
        })
        
        XCTAssert(result.constraints.contains {
            ($0.secondItem === result) &&
            ($0.firstItem === label) &&
            ($0.constant == 0) &&
            ($0.firstAttribute == .leading)
        })
    }
    
    func test_controller() {
        let controller = TestVC()
        let mustEnterDidRender = expectation(description: "must enter didRender")
        controller.didRenderTriggered = {
            mustEnterDidRender.fulfill()
        }
        controller.loadView()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_fontFamilyHelper() {
        let label = layout.children[1].view as? UILabel
        guard
            let familyName = label?.font.fontName,
            let size = label?.font.pointSize else {
            XCTFail("Didn't set family name")
            fatalError()
        }
        XCTAssertEqual(familyName, "AvenirNext-Medium")
        XCTAssertEqualWithAccuracy(size, 30, accuracy: 1)
    }
    
    func test_fontGetters() {
        _ = UILabel.set {
            XCTAssertEqual($0.fontFamily, ".SFUIText")
            $0.fontSize = 30
            XCTAssertEqualWithAccuracy($0.fontSize, 30, accuracy: 1)
        }
    }
    
    func test_doNoCustomView() {
        let v = UIView.do
        let rendered = CanvasRenderer.render(canvas: v)
        XCTAssertNotNil(rendered)
    }
    

}
