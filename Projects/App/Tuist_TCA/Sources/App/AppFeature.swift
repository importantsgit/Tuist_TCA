//
//  AppFeature.swift
//  Tuist_TCA
//
//  Created by 이재훈 on 9/24/24.
//

import ComposableArchitecture

@Reducer
struct AppFeature {

    @ObservableState
    struct State: Equatable {
        var tab1 = CounterFeature.State()
        var tab2 = CounterFeature.State()
    }

    enum Action {
        case tab1(CounterFeature.Action)
        case tab2(CounterFeature.Action)
    }

    var body: some ReducerOf<Self> {
        // 시스템에 액션이 들어오면 각 리듀서는 위에서 아래로 기능의 상태에 대해 실행
        // 현재 각 탭의 기능과 핵심 기능 총 3가지가 포함되어 있음
        // 이렇게 구성하면 각 기능은 독립적으로 작동하면서도 하나의 통합된 앱 구조 안에 존재

        Scope(state: \.tab1, action: \.tab1) {
            CounterFeature()
        }

        Scope(state: \.tab2, action: \.tab2) {
            CounterFeature()
        }

        Reduce { state, action in
            // App Feature에 대한 Core 로직
            return .none
        }
    }
}
