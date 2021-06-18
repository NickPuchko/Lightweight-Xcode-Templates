import Foundation

let templateNames: [String] = [
	"Apple-MVC",
	"SnapkitApp"
].map { $0.appending(".xctemplate")}
let destinationRelativePath = "/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/"

func moveTemplate() {
	var numberOfTemplates = 0
	let fileManager = FileManager.default
	let destinationPath = bash(command: "xcode-select", arguments: ["--print-path"])
		.appending(destinationRelativePath)

	print("Installing \(templateNames.count) templates...\n")
	print("====================================")
	for templateName in templateNames {
		do {
			if !fileManager.fileExists(atPath:"\(destinationPath)/\(templateName)"){
				try fileManager.copyItem(atPath: templateName, toPath: "\(destinationPath)/\(templateName)")
				print("✅  Template \(templateName) installed succesfully.")
			} else {
				try _ = fileManager.replaceItemAt(URL(fileURLWithPath:"\(destinationPath)/\(templateName)"), withItemAt: URL(fileURLWithPath:templateName))
				print("✅  Template \(templateName) already exists.")
			}
			numberOfTemplates += 1
		}
		catch let error as NSError {
			print("❌  Something went wrong: \(error.localizedDescription)")
			print("Failing template: \(templateName)")
		}
	}
	print("====================================\n")
	print("You can find \(numberOfTemplates) amazing templates here: \(destinationPath)")
}

func shell(launchPath: String, arguments: [String]) -> String {
	let task = Process()
	task.launchPath = launchPath
	task.arguments = arguments

	let pipe = Pipe()
	task.standardOutput = pipe
	task.launch()

	let data = pipe.fileHandleForReading.readDataToEndOfFile()
	let output = String(data: data, encoding: String.Encoding.utf8)!
	if output.count > 0 {
		let lastIndex = output.index(before: output.endIndex)
		return String(output[output.startIndex ..< lastIndex])
	}
	return output
}

func bash(command: String, arguments: [String]) -> String {
	let whichPathForCommand = shell(launchPath: "/bin/bash", arguments: [ "-l", "-c", "which \(command)" ])
	return shell(launchPath: whichPathForCommand, arguments: arguments)
}

moveTemplate()
