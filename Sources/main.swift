import AppKit
import Foundation

func getFinderPath() -> String? {
    let script = """
    tell application "Finder"
        if (count of Finder windows) > 0 then
            return POSIX path of (target of front Finder window as alias)
        else
            return POSIX path of (desktop as alias)
        end if
    end tell
    """

    let appleScript = NSAppleScript(source: script)
    var error: NSDictionary?

    guard let output = appleScript?.executeAndReturnError(&error).stringValue,
          error == nil
    else {
        if let errorInfo = error {
            NSLog("AppleScript error: \(errorInfo)")
        }
        return nil
    }

    return output
}

func openInITerm2(path: String) {
    let escapedPath = path.replacingOccurrences(of: "\\", with: "\\\\")
        .replacingOccurrences(of: "\"", with: "\\\"")
    let script = "tell application \"iTerm2\"\n" +
        "set newWindow to create window with default profile\n" +
        "tell newWindow\n" +
        "set fullscreen to false\n" +
        "set bounds to {100, 100, 900, 600}\n" +
        "select\n" +
        "end tell\n" +
        "tell current session of newWindow\n" +
        "write text \"cd \\\"\(escapedPath)\\\"\"\n" +
        "end tell\n" +
        "end tell"
    let appleScript = NSAppleScript(source: script)
    var error: NSDictionary?
    appleScript?.executeAndReturnError(&error)
    if let errorInfo = error {
        NSLog("AppleScript error: \(errorInfo)")
    }
}

guard let finderPath = getFinderPath() else {
    exit(1)
}

openInITerm2(path: finderPath)
