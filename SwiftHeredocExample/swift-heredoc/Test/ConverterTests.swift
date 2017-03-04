//
//  ConverterTests.swift
//  swift-heredoc
//
//  Created by Yusuke on 2017/03/04.
//
//

import Foundation
import XCTest

class ConverterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_convert() {
        
        guard
            let source = self.loadFile(filename: "TestSource"),
            let expect = self.loadFile(filename: "TestSourceExpect") else {
                XCTFail()
                return
        }
        
        let converted = convert(from: source)
        
        print("---INPUT---")
        print(source)
        
        print("---OUTPUT---")
        print(converted)
        
        XCTAssertEqual(converted, expect)
    }

    func loadFile(filename: String) -> String? {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: filename, ofType: "txt") else { return nil }
        return try? String(contentsOfFile: path)
    }
}
