//
//  AppView.swift
//  Tuist_TCA
//
//  Created by 이재훈 on 9/24/24.
//

import ComposableArchitecture
import SwiftUI

struct AppView: View {

    /*
     이러한 분리는 서로 상호작용을 할 수 없기 때문에 이상적이지 않음
     그렇기 때문에 하나의 Store로 묶어 View와 상호작용하는 것
     
     let store1: StoreOf<CounterFeature>
     let store2: StoreOf<CounterFeature>
     */

    let store: StoreOf<AppFeature>

    var body: some View {
        TabView {
            // scope를 사용하여 해당 도메인만 초점을 맞춘 Child Store를 만들 수 있음
            CounterView(store: store.scope(state: \.tab1, action: \.tab1))
                .tabItem {
                    Text("Counter 1")
                }
            CounterView(store: store.scope(state: \.tab1, action: \.tab2))
                .tabItem {
                    Text("Counter 2")
                }
        }
    }
}

#Preview {
    AppView(
        store: Store(
            initialState: AppFeature.State(),
            reducer: {
                AppFeature()
            }
        )
    )
}
