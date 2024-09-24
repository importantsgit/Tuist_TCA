
import ComposableArchitecture
import SwiftUI

@main
struct TuistTCAApp: App {
    // 생성 위치는 크게 두 가지 WindowGroup 내 store로 직접 주입하거나 변수로 빼서 주입
    // static을 사용하는 경우 앱의 다른 부분에서도 쉽게 접근 가능 (App Delegate 또는 백그라운드 작업 같은 경우)
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
            // ._printChanges() -> 디버그용
    }

    var body: some Scene {
        // 애플리케이션을 구동하는 Store은 단 한 번만 생성되어야 한다는 것이 중요 (상태의 일관성과 예측 가능한 동작을 보장하기 위함)
        WindowGroup {
            // WindowGroup 내 store를 직접 주입하는 경우는 앱의 전체 수명 주기 동안 단일 인스턴스를 유지 가능
            AppView(store: TuistTCAApp.store)
        }
    }
}
