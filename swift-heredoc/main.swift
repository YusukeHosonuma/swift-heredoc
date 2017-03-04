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

main(arguments: CommandLine.arguments)
