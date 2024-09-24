//
//  Project.swift
//  AppManifests
//
//  Created by 이재훈 on 9/24/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let tcaProject = Project.app(
    name: Project.appName + "_TODO",
    platform: .iOS,
    bundleId: Project.bundleId2,
    dependencies: [
        .TCA
    ],
    testDependencies: [
        .TCA
    ],
    sourceRootPath: Project.appName + "_TODO"
)

