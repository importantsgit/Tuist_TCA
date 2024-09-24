//
//  CounterFeature.swift
//  Tuist_TCA
//
//  Created by 이재훈 on 9/23/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CounterFeature {
    // 변화하는 상태
    @ObservableState // 지속적으로 추적이 가능하게 해주는 매크로
    // TestStore를 사용하려면 Equatable 상태가 필요하므로 적합성을 추가해야 합니다.
    struct State: Equatable {
        var count = 0
        var isLoading = false
        var isTimerRunning = false
        var fact: String?
    }

    // State를 변화시킬 Action 정의 (Action은 UI에서 수행하는 작업을 문자 그대로 표현해야 함)
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case factButtonTapped

        case toggleTimerButtoneTapped
        case timerTick

        case factResponse(String?)
    }

    // timer의 Task를 취소하기 위한 ID
    enum CancelID { case timer }

    var body: some ReducerOf<Self> {
        Reduce { state, action in // Effect를 반환 / 상태 업데이트
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                return .none

            case .incrementButtonTapped:
                state.count += 1
                return .none // 실행할 Effect를 반환하지 않아도 됨

            case .toggleTimerButtoneTapped:
                state.isTimerRunning.toggle()
                if state.isTimerRunning {
                    return .run { send in
                        while true {
                            try await Task.sleep(for: .seconds(1))
                            await send(.timerTick)
                        }
                    }
                    // 취소 ID 등록
                    .cancellable(id: CancelID.timer)
                } else {
                    // 취소 ID가 있는 Task 취소
                    return .cancel(id: CancelID.timer)
                }

            case .timerTick:
                state.count += 1
                state.fact = nil
                return .none

            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true

                /*
                 Concurrency를 지원하지 않은 함수 내에서 async를 호출한 코드입니다.
                 여기서 나오는 Error는 처리되지 않아요!
                let (data, _) = try await URLSession.shared
                    .data(from: URL(string: "http://numbersapi.com/\(state.count)")!)
                
                state.fact = String(decoding: data, as: UTF8.self)
                state.isLoading = false
                
                return .none
                 */

                /*
                 Reducer가 상태를 변경하여 작업을 처리한 후 Effect라는 것을 반환할 수 있으며, 이는 Store에서 실행되는 비동기 단위를 나타냄
                 Effect는 외부 시스템과 통신한 다음 외부에서 리듀서로 다시 데이터를 공급할 수 있음
                 단, Effect 내에서 State와 상호작용하지 못함 Sendable 클로저가 상태를 캡처할 수 없기 때문
                 */
                return .run { [count = state.count] send in
                    guard let url = URL(string: "http://numbersapi.com/\(count)")
                    else { return }

                    let (data, _) = try await URLSession.shared
                        .data(from: url)
                    let fact = String(decoding: data, as: UTF8.self)
                    await send(.factResponse(fact))
                }

            case let .factResponse(fact):
                state.fact = fact
                state.isLoading = false
                return .none
            }
        }
    }
}
