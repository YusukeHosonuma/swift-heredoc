//
//  Functions.swift
//  swift-heredoc
//
//  Created by Yusuke on 2017/03/04.
//
//

import Foundation

/// .swift ファイル一覧を列挙
func swiftFilePaths(path: String) -> [String] {
    let manager = FileManager.default
    do {
        let paths = try manager.subpathsOfDirectory(atPath: path)
        return paths.filter { $0.hasSuffix(".swift") }
    } catch _ {
        return []
    }
}
