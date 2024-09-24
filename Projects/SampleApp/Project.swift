import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
    name: Project.appName,
    platform: .iOS,
    dependencies: [
        .TCA
    ],
    testDependencies: [
        .TCA
    ],
    sourceRootPath: Project.appName
)

