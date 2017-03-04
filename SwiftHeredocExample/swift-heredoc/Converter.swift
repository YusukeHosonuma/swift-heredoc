//
//  Converter.swift
//  swift-heredoc
//
//  Created by Yusuke on 2017/03/04.
//
//

import Foundation

private let RegexBeginComment = Regex("/\\*")!
private let RegexEndComment   = Regex("\\*/")!
private let RegexLetString    = Regex("let ([0-9A-Za-z]+)\\s*=\\s*\"")!
private let RegexHeredoc      = Regex("(\\s*)<<\\[EOL\\]")!

fileprivate extension String {
    var isBeginComment: Bool {
        return RegexBeginComment.isMatch(self)
    }
    var isEndComment: Bool {
        return RegexEndComment.isMatch(self)
    }
}

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
        
        // here-docを解析して記録
        if inComment {
            
            // インデントを記憶
            if RegexHeredoc.isMatch(line) {
                let space = RegexHeredoc.match(line)!._1
                indent = space.characters.count
                results.append(line)
                continue
            }
            
            // コメント終了
            if line.isEndComment {
                inComment = false
                results.append(line)
                continue
            }
            
            // スペーストリム
            let trimmed = line.substring(from: line.index(line.startIndex, offsetBy: indent ?? 0))
            heredocLines.append(trimmed)
            
            results.append(line)
            continue
            
        } else {
            
            // コメント開始
            if line.isBeginComment {
                inComment = true
                results.append(line)
                continue
            }
            
            // コメントの外に到達してヒアドキュメントが含まれていたら
            if !heredocLines.isEmpty {
                
                if RegexLetString.isMatch(line) {
                    
                    let variable = RegexLetString.match(line)!._1
                    
                    // 文字列リテラルに変換
                    let newLine = convertHeredocToSource(heredocLines,
                                                         variable: variable,
                                                         indent: indent.flatMap{ $0 - 1 })
                    results.append(newLine)
                    
                    heredocLines = []
                    indent = nil
                    continue
                }
                
                heredocLines = []
                indent = nil
            }
        }
        
        // その他の行
        results.append(line)
    }
    
    return String.unlines(results)
}

/// here-docコードから文字列リテラル宣言コードに変換
///
/// - Parameters:
///   - lines: here-docコード
///   - variable: 変数名
///   - indent: インデント
/// - Returns: 変換後のコード
func convertHeredocToSource(_ lines: [String], variable: String, indent: Int?) -> String {
    
    let code = lines.joined(separator: "\\n")
    let escaped = escapeCharacters(code)
    
    let newLine = "let \(variable) = \"\(escaped)\""
    
    if let indent = indent {
        return newLine.leftPad(indent)
    } else {
        return newLine
    }
}

func escapeCharacters(_ line: String) -> String {
    return line.replacingOccurrences(of: "\"", with: "\\\"")
}

