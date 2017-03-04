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
    
    // MARK: - Pattern 1
    
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
    
    
    // MARK: - Pattern 2
    
    /// 初期状態（""）からの変換
    func test2_convertFromInitial() {
        
        guard
            let source = self.loadFile(filename: "TestSource2"),
            let expect = self.loadFile(filename: "TestSourceExpect2") else {
                XCTFail()
                return
        }
        
        let converted = convert(from: source)
        XCTAssertEqual(converted, expect)
    }
    
    /// 変換後の結果からまた変換しても変化しないこと
    func test2_convertFromConverted() {
        
        guard let expect = self.loadFile(filename: "TestSourceExpect2") else {
            XCTFail()
            return
        }
        
        let reConverted = convert(from: expect)
        XCTAssertEqual(reConverted, expect)
    }
    
    
    // MARK: - Pattern 3
    
    /// 初期状態（""）からの変換
    func test3_convertFromInitial() {
        
        guard
            let source = self.loadFile(filename: "TestSource_Regex"),
            let expect = self.loadFile(filename: "TestSource_Regex_Expect") else {
                XCTFail()
                return
        }
        
        let converted = convert(from: source)
        XCTAssertEqual(converted, expect)
    }
    
    /// 変換後の結果からまた変換しても変化しないこと
    func test3_convertFromConverted() {
        
        guard let expect = self.loadFile(filename: "TestSource_Regex_Expect") else {
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
