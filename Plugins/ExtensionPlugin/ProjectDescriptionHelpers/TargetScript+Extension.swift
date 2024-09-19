//
//  TargetScript+Extension.swift
//  ExtensionPlugin
//
//  Created by 이재훈 on 9/19/24.
//

import ProjectDescription

public extension TargetScript {
    
    enum UtilityTool {
        case swiftGen
        case swiftLint
        
        var scriptCommand: String {
            switch self {
            case .swiftGen:
                return "${PROJECT_DIR}/../../Tools/swiftgen config run --config \"${PROJECT_DIR}/TCAPractice/Resources/swiftgen.yml\""
            case .swiftLint:
                return "${PROJECT_DIR}/../../Tools/swiftlint --config \"${PROJECT_DIR}/TCAPractice/Resources/swiftlint.yml\""
            }
        }
    }
    
    // pre로 작성해야 컴파일 전에 실행
    static func prebuildScript(utility: UtilityTool, name: String) -> TargetScript {
        return .pre(script: utility.scriptCommand, name: name)
    }
    
}
