import Foundation

private func main(arguments: [String]) {
    
    let arguments = arguments.dropFirst()

    guard let sourcePath = arguments.first else {
        print("引数を指定してください。")
        return
    }
        
    let paths = swiftFilePaths(path: sourcePath)
    for path in paths {
        
        guard let sourceCode = try? String(contentsOfFile: sourcePath + "/" + path) else {
            continue
        }
        
        let replacedCode = convert(from: sourceCode)
        
        do {
            try replacedCode.write(toFile: sourcePath + "/" + path, atomically: false, encoding: .utf8)
        } catch let error {
            print("🍇 Error: \(error)")
        }
    }
    
    print("\(sourcePath)")
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
        
        // コメントの外に到達してヒアドキュメントが含まれていたら
        if !inComment && !heredocLines.isEmpty {
            
            let regex = Regex("let ([0-9A-Za-z]+)\\s*=\\s*\"")!
            if regex.isMatch(line) {
                let variable = regex.match(line)!._1
                let convertedHeredoc = heredocLines.joined(separator: "\\n")
                // TODO: あとでちゃんとインデントする
                let newLine = "    let \(variable) = \"\(convertedHeredoc)\""
                results.append(newLine)
                
                heredocLines = []
                indent = nil
                continue
            }
            
//            results.append("//" + heredocLines.joined(separator: "🍎"))
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
            // TODO: あとでちゃんと計算する
            let trimmed = line.substring(from: line.index(line.startIndex, offsetBy: 5))
            heredocLines.append(trimmed)
            
            results.append(line)
            continue
        }
        
        // その他の行
        results.append(line)
    }
    
    return String.unlines(results)
}

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

extension String {
    func lines() -> [String] {
        return self.components(separatedBy: "\n")
    }
    
    static func unlines(_ lines: [String]) -> String {
        return lines.joined(separator: "\n")
    }
}



main(arguments: CommandLine.arguments)
