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
    
    /// 初期状態（""）からの変換
    func test_convertFromInitial() {
        
        guard
            let source = self.loadFile(filename: "TestSource"),
            let expect = self.loadFile(filename: "TestSourceExpect") else {
                XCTFail()
                return
        }
        
        let converted = convert(from: source)
        XCTAssertEqual(converted, expect)
    }
    
    /// 変換後の結果からまた変換しても変化しないこと
    func test_convertFromConverted() {
        
        guard let expect = self.loadFile(filename: "TestSourceExpect") else {
            XCTFail()
            return
        }
        
        let reConverted = convert(from: expect)
        XCTAssertEqual(reConverted, expect)
    }

    // MARK: - private
    
    private func loadFile(filename: String) -> String? {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: filename, ofType: "txt") else { return nil }
        return try? String(contentsOfFile: path)
    }
}
