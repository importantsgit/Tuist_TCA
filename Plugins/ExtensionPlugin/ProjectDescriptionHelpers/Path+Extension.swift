//
//  Path+Extension.swift
//  ExtensionPlugin
//
//  Created by 이재훈 on 9/19/24.
//

import ProjectDescription

public extension Path {
    
    static func plistPath(_ plistName: String) -> Path {
        return .relativeToRoot("InfoPlists/\(plistName).plist")
    }
    
    static func xcconfigPath(_ xcconfigName: String) -> Path {
        return .relativeToRoot("XCConfigs/\(xcconfigName).xcconfig")
    }
    
    static func entitlementPath(_ entitle: String) -> Path {
        return .relativeToRoot("Projects/App/Entitlements/\(entitle).entitlements")
    }
    
    static func scriptPath(_ scriptName: String) -> Path {
        return .relativeToRoot("TCAPractice/Tools/\(scriptName)")
    }
    
}

