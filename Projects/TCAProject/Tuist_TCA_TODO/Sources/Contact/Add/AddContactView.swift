//
//  AddContactView.swift
//  Tuist_TCA_TODO
//
//  Created by 이재훈 on 9/24/24.
//

import ComposableArchitecture
import SwiftUI

struct AddContactView: View {
    
    // iOS 17.0 이상
    @Bindable var store: StoreOf<AddContactFeature>
    
    // iOS 16.0 이하는 이렇게
    // @Predicate.Bindable var store: StoreOf<...>
    
    var body: some View {
        Form {
            // bindable할 때 이렇게
            TextField("Name", text: $store.contact.name.sending(\.setName)) // 값이 변할 시 변화된 값이 sending action으로 보내짐
            Button("Save") {
                store.send(.saveButtonTapped)
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Cancel") {
                    store.send(.cancelButtonTapped)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddContactView(
            store: Store(
                initialState: AddContactFeature.State(
                    contact: Contact(
                        id: UUID(),
                        name: "Blob"
                    )
                )
            ) {
                AddContactFeature()
            }
        )
    }
}

struct AddContactView_Delegate: View {
    
    // iOS 17.0 이상
    @Bindable var store: StoreOf<AddContactFeature_Delegate>
    
    // iOS 16.0 이하는 이렇게
    // @Predicate.Bindable var store: StoreOf<...>
    
    var body: some View {
        Form {
            // bindable할 때 이렇게
            TextField("Name", text: $store.contact.name.sending(\.setName)) // 값이 변할 시 변화된 값이 sending action으로 보내짐
            Button("Save") {
                store.send(.saveButtonTapped)
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Cancel") {
                    store.send(.cancelButtonTapped)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddContactView_Delegate(
            store: Store(
                initialState: AddContactFeature_Delegate.State(
                    contact: Contact(
                        id: UUID(),
                        name: "Blob"
                    )
                )
            ) {
                AddContactFeature_Delegate()
            }
        )
    }
}
