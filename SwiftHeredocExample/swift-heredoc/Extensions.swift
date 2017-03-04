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
    
    static func unlines(_ lines: [String]) -> String {
        return lines.joined(separator: "\n")
    }
}
