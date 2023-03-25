//
//  UserItemView.swift
//  Test
//
//  Created by Dmytro Savka on 25.03.2023.
//

import SwiftUI

struct UserItemView: View {
    
    @EnvironmentObject var viewModel: UsersViewModel
    
    let user: User
    
    var body: some View {
        if let user = viewModel.userByID(userID: user.id) {
            NavigationLink(destination: UserDetailsView(user: user).environmentObject(viewModel)) {
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
                                    .foregroundColor(.primary)
                                    .bold()
                                    .padding(.top)
                                
                                if viewModel.isSaved(user: user) {
                                    Image(systemName: "person.fill")
                                        .font(.title3)
                                        .foregroundColor(.primary)
                                        .bold()
                                        .padding(.top)
                                    
                                }
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                
                                if viewModel.isSaved(user: user) {
                                    Button {
                                            viewModel.deleteData(userID: user.id)
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                            .font(.title)
                                    }
                                    .frame(width: 20, height: 20)
                                    .padding(.horizontal)
                                } else {
                                    Button {
                                            viewModel.addUserToSaved(user: user)
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
