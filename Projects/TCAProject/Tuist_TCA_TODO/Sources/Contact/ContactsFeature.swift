//
//  ContactsFeature.swift
//  Tuist_TCA_TODO
//
//  Created by 이재훈 on 9/24/24.
//

import ComposableArchitecture
import Foundation

struct Contact: Equatable, Identifiable {
    let id: UUID
    var name: String
}

@Reducer
struct ContactsFeature {
    
    @ObservableState
    struct State {
        /*
         // 기능 State를 통합하기 위해 Presents 매크로 (옵셔널)에 보관
         // nil값은 표시되지 않음을 뜻함 / nil이 아닌 값은 표시되고 있음
         @Presents var addContact: AddContactFeature.State?
         @Presents var addContact_delegate: AddContactFeature_Delegate.State?
         
         // 알랏
         @Presents var alert: AlertState<Action.Alert>?
         */
        @Presents var destination: Destination.State?
        
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action {
        case addButtonTapped
        case addButtonTapped_delegate
        case deleteButtonTapped(id: Contact.ID)
        case destination(PresentationAction<Destination.Action>)
        
        // 알랏
        //case alert(PresentationAction<Alert>)
        // 취소 동작은 자동으로 추가되어 있음
        enum Alert: Equatable {
            case confirmDeletion(id: Contact.ID)
        }
        
        
        
        /*
         // 이 액션을 통해 부모-자식 기능 간의 액션 흐름을 관리
         // 부모가 자식 기능에서 발생하는 모든 액션을 관찰할 수 있음
         // 이는 자식 기능에서 발생한 액션을 부모 기능에서 처리하거나 반응할 수 있게 됨
         case addContact(PresentationAction<AddContactFeature.Action>)
         // 단 이럴 경우 부모가 자식의 내부 동작을 너무 자세히 알아야 하고,
         // 부모가 자식의 액션에 대해 가정을 하게 됨 (모든 이벤트를 감지하여 일일히 구분해야 함)
         // 따라서 해당 문제를 delegate로 해결할 수 있음 (부모가 필요한 기능만 delegate로 보내 부모의 역할을 확실히 함)
         case addContact_delegate(PresentationAction<AddContactFeature_Delegate.Action>)
         // 취소 기능이 번거로울 수 있는데 이 경우 dismiss 구현으로 해결
         */
    }
    
    @Reducer
    enum Destination {
        case addContact(AddContactFeature)
        case addContact_delegate(AddContactFeature_Delegate)
        case alert(AlertState<ContactsFeature.Action.Alert>)
    }
    

    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                //state.addContact = .init(contact: Contact(id: UUID(), name: ""))
                state.destination = .addContact(
                    AddContactFeature.State(
                        contact: Contact(id: UUID(), name: "")
                    )
                )
                return .none
                
            case .addButtonTapped_delegate:
                state.destination = .addContact_delegate(
                    AddContactFeature_Delegate.State(
                        contact: Contact(id: UUID(), name: "")
                    )
                )
                return .none
                
                //MARK: - 직접 action 가져오기
                // presented를 활용하여 연락처 추가 기능 내부에서 발생하는 액션을 감지
                // presented는 해당 자식이 nil이 아닌 경우 / 활성화 된 경우만 값을 받을 수 있음
                // represents an action happening inside the child feature
            case .destination(.presented(.cancelButtonTapped)):
                print("cancelButtonTapped")
                state.addContact = nil
                return .none
                
                // 자식 contact를 부모 Store로 전달하는 방법
            case .destination(.presented(.saveButtonTapped)):
                guard let contact = state.addContact?.contact // 해당 값 가져오기
                else { return .none }
                
                state.contacts.append(contact)
                state.addContact = nil
                return .none
                
                //MARK: - Delegate
                // delegate를 이용하여 취소
                /* 이 코드는 번거롭기 떄문에 의존성을 이용하여 해결
                 case .addContact_delegate(.presented(.delegate(.cancel))):
                 state.addContact_delegate = nil
                 return .none
                 */
                
                // delegate를 이용하여 contact를 가져오기
            case let .destination(.presented(.delegate(.saveContact(contact)))):
                state.contacts.append(contact)
                return .none
                
            case let .destination(.presented(.confirmDeletion(id: id))):
                state.contacts.remove(id: id)
                return .none
                
                /*
                 // 자식 Present가 nil 상태로 변화할 때 호출
                 // represents dismissing the child feature by nil-ing its state.
                 // TODO: 왜 호출이 안될까요??
                 case .destination(.dismiss):
                 print("dismiss")
                 return .none
                 
                 case .addContact_delegate:
                 return .none
                 
                 case .addContact:
                 return .none
                 
                 
                 
                 case .alert:
                 return .none
                 */
                
            case .destination:
                return .none
                
            case let .deleteButtonTapped(id: id):
                state.destination = .alert(
                    AlertState {
                        TextState("Are yout sure?")
                    } actions: {
                        ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                            TextState("Delete")
                        }
                    }
                )
                
                return .none
                
                
            }
        }
        /*
         .ifLet(\.$addContact, action: \.addContact) {
         AddContactFeature()
         }
         .ifLet(\.$addContact_delegate, action: \.addContact_delegate) {
         AddContactFeature_Delegate()
         }
         .ifLet(\.$alert, action: \.alert)
         */
        .ifLet(\.$destination, action: \.destination)
    }
    

}

// MARK: - @Presents 값을 추가시키면 옵셔널한 값이 계속 추가
// 이를 해결하기 위해 Destination이라는 새로운 리듀서를 정의



extension ContactsFeature.Destination.State: Equatable {}
