//
//  HomeView.swift
//  Test
//
//  Created by Dmytro Savka on 22.03.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: UsersViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 15) {
                    ForEach(viewModel.users, id: \.id) { user in
                        UserItemView(user: user).environmentObject(viewModel)
                    }
                }
            }
            .navigationTitle("Home")
            .onAppear(perform: viewModel.fetchRequestUsers)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = UsersViewModel()
        HomeView().environmentObject(viewModel)
    }
}
