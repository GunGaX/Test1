//
//  FavoritesUsersView.swift
//  Test
//
//  Created by Dmytro Savka on 22.03.2023.
//

import SwiftUI

struct FavoritesUsersView: View {
    
    @EnvironmentObject var viewModel: UsersViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(viewModel.savedUsers, id: \.id) { savedUser in
                        if let user = viewModel.userByID(userID: savedUser.id) {
                            UserItemView(user: user).environmentObject(viewModel)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

