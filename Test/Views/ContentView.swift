//
//  ContentView.swift
//  Test
//
//  Created by Dmytro Savka on 21.03.2023.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject private var viewModel = UsersViewModel()
    
    var body: some View {
        TabView {
            HomeView().environmentObject(viewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            FavoritesUsersView().environmentObject(viewModel)
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
