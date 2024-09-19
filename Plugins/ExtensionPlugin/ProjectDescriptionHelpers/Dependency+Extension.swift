//
//  Dependency+Extension.swift
//  ExtensionPlugin
//
//  Created by 이재훈 on 9/19/24.
//

import ProjectDescription

public extension TargetDependency {
    static let TCA: TargetDependency = .external(name: "ComposableArchitecture")
}

public extension Package {
    static let TCA: Package = .remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .upToNextMajor(from: "1.10.1"))
}
