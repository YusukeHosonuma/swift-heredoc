//
//  Extensions.swift
//  swift-heredoc
//
//  Created by Yusuke on 2017/03/04.
//
//

import Foundation

extension String {
    
    func lines() -> [String] {
        return self.components(separatedBy: "\n")
    }
    
    func leftPad(_ n: Int) -> String {
        let indent = String(repeating: " ", count: n)
        return indent + self
    }
    
    /// 文字列リテラル内で禁止される文字をエスケープ
    ///
    /// - Parameter line: コード
    /// - Returns: 結果
    func escapeStringLiteralCharacters() -> String {
        var line = self
        line = line.replacingOccurrences(of: "\\", with: "\\\\")
        line = line.replacingOccurrences(of: "\"", with: "\\\"")
        return line
    }
    
    static func unlines(_ lines: [String]) -> String {
        return lines.joined(separator: "\n")
    }
}
