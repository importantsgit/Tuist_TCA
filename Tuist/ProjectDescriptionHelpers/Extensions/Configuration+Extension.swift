//
//  Configuration+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by 이재훈 on 9/20/24.
//

import ProjectDescription

public extension Configuration {
    
    enum ConfigScheme: ConfigurationName, CaseIterable {
        case debug = "Debug"
        case release = "Release"
    }
    
    static func configure(configurations: [ConfigScheme]) -> [Configuration] {
        return configurations.map { $0.rawValue }.map { configName -> Configuration in
            return configName == .release ?
                .release(name: configName, xcconfig: .xcconfigPath(configName.rawValue)) :
                .debug(name: configName, xcconfig: .xcconfigPath(configName.rawValue))
        }
    }
}
