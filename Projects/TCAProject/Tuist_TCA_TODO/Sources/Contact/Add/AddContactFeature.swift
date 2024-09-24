//
//  AddContactFeature.swift
//  Tuist_TCA_TODO
//
//  Created by 이재훈 on 9/24/24.
//

import ComposableArchitecture

@Reducer
struct AddContactFeature {
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }
    enum Action {
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
    }
    
    var body: some ReducerOf<Self> {
    
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .none
                
            case .saveButtonTapped:
                return .none

            case let .setName(name):
                state.contact.name = name
                return .none
            }
        }
    }
}

/*
 이 로직은 바인딩 시 모든 case를 정리하지 않고 작성하는 방법
@Reducer
struct ContactFeature {
    @ObservableState
    struct State: Equatable {
        var contact: Contact?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
            .onChange(of: \.contact.name) { oldValue, newValue in
                // request Effect 없으면 제거
            }
    }
}
*/
