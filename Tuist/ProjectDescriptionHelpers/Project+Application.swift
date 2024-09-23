//
//  Project+Application.swift
//  AppManifests
//
//  Created by 이재훈 on 9/20/24.
//

import ProjectDescription

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
                .prebuildScript(
                    utility: .swiftLint,
                    name: "Run Lint"
                )
            ],
            dependencies: dependencies,
            testDependencies: testDependencies
        )
        
        return .init(
            name: name,
            targets: targets,
            resourceSynthesizers: []
        )
    }
    
    private static func makeAppTargets(
        name: String,
        destinations: Destinations = .iOS,
        productName: String? = productName,
        bundleId: String = bundleId,
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
            bundleId: bundleId,
            deploymentTargets: deploymentTargets,
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleDevelopmentRegion": "ko_KR",
                    "CFBundleShortVersionString": "1.0.0",
                    "CFBundleVersion": "1",
                    "UILaunchStoryboardName": "LaunchScreen",
                    "CFBundleIconName": "AppIcon",
                    "NSAppTransportSecurity": [
                        "NSAllowsArbitraryLoads": true
                    ],
                ]
            ),
            sources: ["Tuist_TCA/Sources/**"],
            resources: ["Tuist_TCA/Resources/**"],
            scripts: scripts,
            dependencies: dependencies,
            settings: .settings(
                base: [:],
                configurations: Configuration.configure(
                    configurations: Configuration.ConfigScheme.allCases
                )
            ),
            coreDataModels: coreDataModels
        )
        
        let testTarget: Target = .target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "\(bundleId).tests",
            sources: ["Tuist_TCA/Tests/**"],
            scripts: scripts,
            dependencies: testDependencies
        )
        
        return [
            mainTarget,
            testTarget
        ]
    }
    
}
