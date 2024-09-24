//
//  AddContactFeature_Delegate.swift
//  Tuist_TCA_TODO
//
//  Created by 이재훈 on 9/24/24.
//

import ComposableArchitecture

@Reducer
struct AddContactFeature_Delegate {
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }
    enum Action {
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
        
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case saveContact(Contact)
        }
    }
    @Dependency(\.dismiss) var dismiss // 의존성은 비동기적으로 Effect에서만 호출
    
    var body: some ReducerOf<Self> {
    
        Reduce { state, action in
            switch action {
                // delegate로 선언된 enum
            case .cancelButtonTapped:
                return .run { _ in await self.dismiss() }
            
            case .saveButtonTapped:
                return .run { [contact = state.contact] send in
                    await send(.delegate(.saveContact(contact)))
                    await self.dismiss()
                }

            case .delegate:
                return .none
                
            case let .setName(name):
                state.contact.name = name
                return .none
            }
        }
    }
}


