import Foundation

private func main(arguments: [String]) {
    
    let arguments = arguments.dropFirst()

    guard let sourcePath = arguments.first else {
        print("引数を指定してください。")
        return
    }
    
    let fileName = "AppDelegate.swift"
    let sourceCode = try? String(contentsOfFile: sourcePath + "/" + fileName)
    let replacedCode = sourceCode?.replacingOccurrences(
        of: "let string = \"\"",
        with: "let string = \"Banana\\nApple\\nOrange\""
    )
    print(replacedCode!)
    _ = try! replacedCode?.write(toFile: sourcePath + "/" + fileName, atomically: false, encoding: .utf8)
    
    print("\(sourcePath)")
}

func conver(from string: String) -> String {
    
    return ""
}

main(arguments: CommandLine.arguments)
