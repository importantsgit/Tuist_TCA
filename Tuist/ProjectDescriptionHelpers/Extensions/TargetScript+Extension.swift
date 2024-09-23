//
//  TargetScript+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by 이재훈 on 9/20/24.
//

import ProjectDescription
import Foundation

public extension TargetScript {
    enum UtilityTool {
        case swiftLint
        
        var scriptCommand: String {
            switch self {
            case .swiftLint:
                return """
if [ -f "${PROJECT_DIR}/Tuist_TCA/Resources/swiftlint.yml" ]; then
  "${PROJECT_DIR}/../../Tools/swiftlint" --config "${PROJECT_DIR}/Tuist_TCA/Resources/swiftlint.yml"
else
  echo "warning: SwiftLint configuration file not found"
fi
"""
            }
        }
    }
    
    static func prebuildScript(utility: UtilityTool, name: String) -> TargetScript {
        return .pre(script: utility.scriptCommand, name: name, basedOnDependencyAnalysis: false)
    }
    
}


