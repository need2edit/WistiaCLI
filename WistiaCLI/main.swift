//
//  main.swift
//  WistiaCLI
//
//  Created by Jake Young on 6/12/17.
//  Copyright © 2017 Jake young. All rights reserved.
//

import Foundation

struct ErrorEnvelope: Codable {
    let code: String?
    let error: String
}

let data = DataAPI()

func printRoutes() {
    for route in DataAPI.Route.allValues {
        let url = DataAPI.url(route: route)
        print(url)
    }
}

//func BlockingGet(url:String)->String? {
//    let sema=dispatch_semaphore_create(0)
//    let url:NSURL!=NSURL(string:url)
//    var output:String?
//    NSURLSession.sharedSession().dataTaskWithURL(url) {
//        data, response, error in
//        output = NSString(data: data!, encoding: NSUTF8StringEncoding) as String?
//        dispatch_semaphore_signal(sema)
//        }!.resume()
//    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER)
//    return output
//}

func parseResponse(code: Int, data: Data, option: OptionType) -> Codable? {
    
    let decoder = JSONDecoder()
    let string = String.init(data: data, encoding: .utf8)
    print(string)
    
    if code == 401 || code == 404 {
        let error = try? decoder.decode(ErrorEnvelope.self, from: data)
        return error
    } else {
        switch option {
        case .projects:
            return try? decoder.decode([Project].self, from: data)
        case .project:
            return try? decoder.decode(Project.self, from: data)
        case .medias:
            return try? decoder.decode([Media].self, from: data)
        case .media:
            return try? decoder.decode(Media.self, from: data)
        case .unknown, .help:
            return nil
        }
    }
    
}


private func url(option: OptionType, value: String) -> URL? {
    switch option {
    case .projects:
        return DataAPI.url(route: .projects)
    case .project:
        return DataAPI.url(route: .project(value))
    case .medias:
        return DataAPI.url(route: .medias)
    case .media:
        return DataAPI.url(route: .media(value))
    case .unknown, .help:
        return nil
    }
}

func blockingGETRequest(option: OptionType, value: String) -> Codable? {
    
    guard let url = url(option: option, value: value) else { return nil }
    
    let sema = DispatchSemaphore.init(value: 0)
    var output: Codable?
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        
        guard let data = data, let response = response as? HTTPURLResponse else {
            sema.signal()
            return
        }
        
        output = parseResponse(code: response.statusCode, data: data, option: option)
        sema.signal()
    }.resume()
    let _ = sema.wait(timeout: DispatchTime.distantFuture)
    return output
}

class WistiaCLI {
    let data = DataAPI()
    let stats = StatsAPI()
    let consoleIO = ConsoleIO()
    
    func staticMode() {
        //1
        let argCount = CommandLine.argc
        //2
        let argument = CommandLine.arguments[1]
        //3
        let (option, value) = consoleIO.getOption(argument.substring(from: argument.characters.index(argument.startIndex, offsetBy: 1)))
        //4
        
        let info = CommandLine.arguments[2]
        let identifierInfo = consoleIO.getOption(info.substring(from: info.characters.index(info.startIndex, offsetBy: 0)))
        
        guard let output = blockingGETRequest(option: option, value: identifierInfo.value) else { return }
        print(output)
        
        print("Argument count: \(argCount) Option: \(option) value: \(value)")
    }
}

let cli = WistiaCLI()

if CommandLine.argc < 2 {
    
} else {
    cli.staticMode()
}
