//
//  Config.swift
//  Packages
//
//  Created by 이재훈 on 9/19/24.
//

// ProjectDescriptionHelpers를 사용하기 위한 Config 정의
import ProjectDescription

let config = Config(
    plugins: [
        .local(path: .relativeToRoot("Plugins/ExtensionPlugin"))
    ]
)


