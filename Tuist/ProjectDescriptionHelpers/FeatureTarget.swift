//
//  FeatureTarget.swift
//  Config
//
//  Created by 이재훈 on 9/19/24.
//

import ProjectDescription

public enum FeatureTarget: CaseIterable {
    case app
    case interface
    case demo
    case testing
    case tests
    case dynamicFramework
    case staticFramwork
    
    public var isFramework: Bool {
        switch self {
        case .dynamicFramework, .staticFramwork: return true
        default: return false
        }
    }
}

