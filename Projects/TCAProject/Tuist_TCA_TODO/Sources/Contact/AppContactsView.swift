//
//  AppContactFeature.swift
//  Tuist_TCA_TODO
//
//  Created by 이재훈 on 9/24/24.
//

import ComposableArchitecture
import SwiftUI

struct ContactsView: View {
    // Store에 대한 바인딩을 생성
    @Bindable var store: StoreOf<ContactsFeature>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.contacts) { contact in
                    HStack {
                        Text(contact.name)
                            .foregroundStyle(.black)
                        Spacer()
                        Button {
                            store.send(.deleteButtonTapped(id: contact.id))
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem {
                    Button {
                        store.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem {
                    Button {
                        store.send(.addButtonTapped_delegate)
                    } label: {
                        Image(systemName: "pencil")
                    }
                }
            }
            //addContact가 non-nil일 때 시트를 표시하는 Sheet을 사용 optional한 store을 반환 
            // -> Sheet의 item이 nil일 경우 노출 X (SwiftUI의 선언적 UI 구성 방식을 따름)
            .sheet(
                item: $store.scope(
                    state: \.destination?.addContact,
                    action: \.destination?.addContact
                )
            ) { addContactStore in
                NavigationStack {
                    AddContactView(store: addContactStore)
                }
            }
            .sheet(
                item: $store.scope(
                    state: \.destination?.addContact_delegate,
                    action: \.destination?.addContact_delegate
                )
            ) { addContactStore in
                NavigationStack {
                    AddContactView_Delegate(store: addContactStore)
                }
            }
            .alert($store.scope(state: \.destination?.alert, action: \.destination?.alert))
        }
    }
}

#Preview {
    ContactsView(
        store: .init(
            initialState: ContactsFeature.State(
                contacts: [
                    Contact(id: UUID(), name: "jaehun"),
                    Contact(id: UUID(), name: "jaehun"),
                    Contact(id: UUID(), name: "jaehun")
                ]
            )
        ) {
            ContactsFeature()
        }
    )
}



