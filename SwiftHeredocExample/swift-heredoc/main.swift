import Foundation

private func main(arguments: [String]) {
    
    let arguments = arguments.dropFirst()

    guard let sourcePath = arguments.first else {
        print("引数を指定してください。")
        return
    }
        
    let paths = swiftFilePaths(path: sourcePath)
    for path in paths {
        
        let sourceCode = try? String(contentsOfFile: sourcePath + "/" + path)
        let replacedCode = sourceCode?.replacingOccurrences(
            of: "let string = \"\"",
            with: "let string = \"Banana\\nApple\\nOrange🍊\""
        )

        //print(replacedCode!)
        
        do {
            try replacedCode?.write(toFile: sourcePath + "/" + path, atomically: false, encoding: .utf8)
        } catch let error {
            print("🍇 Error: \(error)")
        }
    }
    
    print("\(sourcePath)")
}

func conver(from string: String) -> String {
    
    return ""
}

/// .swift ファイル一覧を列挙
func swiftFilePaths(path: String) -> [String] {
    let manager = FileManager.default
    do {
        let paths = try manager.subpathsOfDirectory(atPath: path)
        return paths.filter { $0.hasSuffix(".swift") }
    } catch let error {
        return []
    }
}

main(arguments: CommandLine.arguments)
