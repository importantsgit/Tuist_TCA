//
//  Path+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by 이재훈 on 9/20/24.
//

import ProjectDescription

extension Path {
  
  public static func plistPath(_ plistName: String) -> Path {
    return .relativeToRoot("InfoPlists/\(plistName).plist")
  }
  
  public static func xcconfigPath(_ xcconfigName: String) -> Path {
    return .relativeToRoot("XCConfigs/\(xcconfigName).xcconfig")
  }
  
  public static func scriptPath(_ scriptName: String) -> Path {
    return .relativeToRoot("SaveEarth/Tools/\(scriptName)")
  }
  
}

