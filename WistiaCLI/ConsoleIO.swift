//
//  ConsoleIO.swift
//  WistiaCLI
//
//  Created by Jake Young on 6/12/17.
//  Copyright © 2017 Jake young. All rights reserved.
//

import Foundation

// MARK: - Console Input Options

enum OptionType: String {
    case projects = "projects"
    case project = "p"
    case media = "m"
    case medias = "medias"
    case help = "h"
    case unknown
    
    init(value: String) {
        switch value {
        case "projects": self = .projects
        case "medias": self = .medias
        case "m": self = .media
        case "p": self = .project
        case "h": self = .help
        default: self = .unknown
        }
    }
}

// MARK: - Console Input & Output

class ConsoleIO {
    
    // MARK: -
    
    func getOption(_ option: String) -> (option: OptionType, value: String) {
        return (OptionType(value: option), option)
    }
    
    // MARK: -
    
    class func printUsage() {
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        
        print("Welcome to WistiaCLI!")
        print("")
        print("List projects:")
        print("\(executableName) -projects")
        print("")
        print("Show project:")
        print("\(executableName) -p project_id")
        print("")
        print("List medias:")
        print("\(executableName) -medias")
        print("")
        print("Show Media:")
        print("\(executableName) -m media_id")
        print("")
        print("\(executableName) -h to show usage information")
        print("Type \(executableName) without an option to enter interactive mode.")
    }
}
