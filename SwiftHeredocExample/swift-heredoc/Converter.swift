//
//  Converter.swift
//  swift-heredoc
//
//  Created by Yusuke on 2017/03/04.
//
//

import Foundation

/// 指定されたコード全体を変換したものを返す
///
/// - Parameter string: ソースコード全体
/// - Returns: 変換後のソースコード
func convert(from text: String) -> String {
    
    // コメント中か？
    var inComment: Bool = false
    
    // ヒアドキュメントの文字列を記憶
    var heredocLines: [String] = []
    
    // ヒアドキュメントのインデント
    var indent: Int? = nil
    
    // 変換結果
    var results: [String] = []
    
    for line in text.lines() {
        
        // コメントの外に到達してヒアドキュメントが含まれていたら
        if !inComment && !heredocLines.isEmpty {
            
            let regex = Regex("let ([0-9A-Za-z]+)\\s*=\\s*\"")!
            if regex.isMatch(line) {
                let variable = regex.match(line)!._1
                
                let strintLiteral = convertHeredocToSource(heredocLines)
                
                let newLine = "let \(variable) = \"\(strintLiteral)\""
                if let indent = indent {
                    results.append(newLine.leftPad(indent - 1))
                } else {
                    results.append(newLine)
                }
                
                heredocLines = []
                indent = nil
                continue
            }
            
            heredocLines = []
            indent = nil
        }
        
        // コメント開始
        if Regex("/\\*")!.isMatch(line) {
            inComment = true
            results.append(line)
            continue
        }
        
        // here-docを解析して記録
        if inComment {
            
            // インデントを記憶
            if Regex("(\\s*)<<\\[EOL\\]")!.isMatch(line) {
                let space = Regex("(\\s*)<<\\[EOL\\]")!.match(line)!._1
                indent = space.characters.count
                results.append(line)
                continue
            }
            
            // コメント終了
            if Regex("\\*/")!.isMatch(line) {
                inComment = false
                results.append(line)
                continue
            }
            
            // スペーストリム
            let trimmed = line.substring(from: line.index(line.startIndex, offsetBy: indent ?? 0))
            heredocLines.append(trimmed)
            
            results.append(line)
            continue
        }
        
        // その他の行
        results.append(line)
    }
    
    return String.unlines(results)
}

func convertHeredocToSource(_ lines: [String]) -> String {
    
    let code = lines.joined(separator: "\\n")
    let escaped = escapeCharacters(code)
    return escaped
}

func escapeCharacters(_ line: String) -> String {
    return line.replacingOccurrences(of: "\"", with: "\\\"")
}

