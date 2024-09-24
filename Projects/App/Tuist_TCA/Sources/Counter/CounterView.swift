//
//  CounterView.swift
//  Tuist_TCA
//
//  Created by 이재훈 on 9/23/24.
//

import ComposableArchitecture
import SwiftUI

/*
 기능의 런타임을 나타냄
 상태를 업데이트하기 위해 액션을 처리할 수 있고, 효과를 실행하며 그 효과로부터 얻은 데이터를 다시 시스템에 피드백할 수 있는 객체
 */

struct CounterView: View {
    let store: StoreOf<CounterFeature>
    // 제네릭이기 때문에 다양한 리듀서와 작동할 수 있음
    // 또한, let으로 선언이 가능하고, ObservableState() 매크로를 통해 Store의 상태 변화를 자동으로 관찰할 수 있게 해줌

    var body: some View {
        VStack {
            Text("\(store.count)")
                .font(.largeTitle)
                .padding()
                .background(Color.blue)
                .clipShape(.buttonBorder)
            HStack {
                Button("-") {
                    store.send(.decrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.gray.opacity(0.3))
                Button("+") {
                    store.send(.incrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.gray.opacity(0.3))
            }
            Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
                store.send(.toggleTimerButtoneTapped)
            }
            Button("Fact") {
                store.send(.factButtonTapped)
            }
            .font(.largeTitle)
            .padding()
            .background(Color.gray.opacity(0.3))

            if store.isLoading {
                 ProgressView()
            } else if let fact = store.fact {
                Text(fact)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
}

#Preview {
    CounterView(
        store: .init(initialState: CounterFeature.State()){
            CounterFeature()
        }
    )
}

/*
 부작용이란?
 
 부작용은 API 요청, 파일 시스테과의 상호 작용, 시간 기반 비동기 수행 등 외부와 소통할 수 있게 해줌
 원래 동일한 상태와 동일한 동작으로 항상 동일한 결과를 얻게 되는데 부작용은 외부의 영향을 받기 때문에 다른 결과를 얻을 수 있음
 */
