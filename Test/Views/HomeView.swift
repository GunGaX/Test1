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
                LazyVStack (spacing: 15) {
                    ForEach(viewModel.users, id: \.id) { user in
                        NavigationLink(destination: UserDetailsView(user: viewModel.userByID(userID: user.id)!).environmentObject(viewModel)) {
                            ZStack {
                                Rectangle().fill(Color.gray.opacity(0.15))
                                
                                HStack {
                                    AsyncImage(url: URL(string: user.avatarUrl), content: { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                    },
                                               placeholder: {
                                        ProgressView()
                                    })
                                    .frame(width: 130)
                                    
                                    VStack {
                                        HStack {
                                            Text(user.login)
                                                .font(.title3)
                                                .foregroundColor(.black)
                                                .bold()
                                                .padding(.top)
                                            
                                            if viewModel.isSaved(user: user) {
                                                Image(systemName: "person.fill")
                                                    .font(.title3)
                                                    .foregroundColor(.black)
                                                    .bold()
                                                    .padding(.top)
                                                
                                            }
                                            Spacer()
                                        }
                                        
                                        HStack {
                                            Spacer()
                                            
                                            if viewModel.isSaved(user: user) {
                                                Button {
                                                    withAnimation {
                                                    viewModel.deleteData(userID: user.id)
                                                }
                                                } label: {
                                                    Image(systemName: "trash")
                                                        .foregroundColor(.red)
                                                        .font(.title)
                                                }
                                                .frame(width: 20, height: 20)
                                                .padding(.horizontal)
                                            } else {
                                                Button {
                                                    withAnimation {
                                                    viewModel.addUserToSaved(user: user)
                                                }
                                                } label: {
                                                    Image(systemName: "plus.app")
                                                        .foregroundColor(.orange)
                                                        .font(.title)
                                                }
                                                .frame(width: 20, height: 20)
                                                .padding(.horizontal)
                                            }
                                        }
                                        
                                        HStack {
                                            Text(user.reposUrl)
                                                .font(.callout)
                                                .foregroundColor(.gray)
                                                .padding([.top, .trailing, .bottom])
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .frame(height: 130)
                            .cornerRadius(16)
                            .padding(.horizontal)
                        }
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
