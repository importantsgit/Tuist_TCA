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
        
        func scriptCommand(root: String) -> String {
            switch self {
            case .swiftLint:
                return """
if [ -f "${PROJECT_DIR}/\(root)/Resources/swiftlint.yml" ]; then
  "${PROJECT_DIR}/../../Tools/swiftlint" --config "${PROJECT_DIR}/\(root)/Resources/swiftlint.yml"
else
  echo "warning: SwiftLint configuration file not found"
fi
"""
            }
        }
    }
    
    static func prebuildScript(utility: UtilityTool, name: String, root: String) -> TargetScript {
        return .pre(script: utility.scriptCommand(root: root), name: name, basedOnDependencyAnalysis: false)
    }
    
}


