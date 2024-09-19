//
//  Project+Application.swift
//  Config
//
//  Created by 이재훈 on 9/19/24.
//

import ProjectDescription
import ExtensionPlugin

extension Project {
   public static func app(
        name: String,
        platform: Platform,
        dependencies: [TargetDependency],
        testDependencies: [TargetDependency]
    ) -> Project {
        let targets = makeAppTargets(
            name: name,
            scripts: [
                .prebuildScript(utility: .swiftGen, name: "Gen"),
                .prebuildScript(utility: .swiftLint, name: "Lint")
            ],
            dependencies: dependencies,
            testDependencies: testDependencies
        )
        
        return .init(name: name, targets: targets, resourceSynthesizers: [])
    }
    
    private static func makeAppTargets(
        name: String,
        destinations: Destinations = .iOS,
        productName: String? = productName,
        bindleId: String = bundleId,
        deploymentTargets: DeploymentTargets? = deployTarget,
        scripts: [TargetScript],
        dependencies: [TargetDependency],
        testDependencies: [TargetDependency],
        coreDataModels: [CoreDataModel] = []
    ) -> [Target] {
        let mainTarget: Target = .target(
            name: name,
            destinations: destinations,
            product: .app,
            productName: productName,
            bundleId: bindleId,
            deploymentTargets: deploymentTargets,
            infoPlist: .extendingDefault(with: [
              "CFBundleDevelopmentRegion": "ko_KR",
              "CFBundleShortVersionString": "1.0.0",
              "CFBundleVersion": "1",
              "UILaunchStoryboardName": "LaunchScreen",
              "CFBundleIconName": "AppIcon",
              "NSAppTransportSecurity": [
                "NSAllowsArbitraryLoads": true
              ]
            ]),
            sources: ["TCAPractice/Sources/**"],
            resources: ["TCAPractice/Resources/**"],
            entitlements: .file(path: .entitlementPath("TCAPractice")),
            scripts: scripts,
            dependencies: dependencies,
            settings: .settings(base: [:], configurations: Configuration.configure(configuration: Configuration.ConfigScheme.allCases)),
            coreDataModels: coreDataModels
        )
        
        let testTarget: Target = .target(
          name: "\(name)Tests",
          destinations: destinations,
          product: .unitTests,
          bundleId: "\(bundleId).tests",
          sources: ["TCAPractice/Tests/**"],
          resources: [],
          scripts: scripts,
          dependencies: testDependencies
        )
        
        return [mainTarget, testTarget]
    }
}
