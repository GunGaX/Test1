//
//  UserDetailsView.swift
//  Test
//
//  Created by Dmytro Savka on 22.03.2023.
//

import SwiftUI

struct UserDetailsView: View {
    
    @EnvironmentObject var viewModel: UsersViewModel
    
    var user: User
    
    @State private var isLoading = false
    
    var body: some View {
        ScrollView {
            LazyVStack (spacing: 15) {
                if isLoading {
                    ProgressView()
                } else {
                    ForEach(viewModel.repos, id: \.id) { repo in
                        ZStack {
                            Rectangle().fill(Color.gray.opacity(0.15))
                            
                            VStack {
                                HStack {
                                    Text("Name:")
                                        .padding()
                                    Spacer()
                                    
                                    Text(repo.name)
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                        .padding()
                                }
                                
                                HStack {
                                    Image(systemName: "chart.bar.doc.horizontal.fill")
                                        .foregroundColor(.black.opacity(0.5))
                                        .padding()

                                    Text(repo.language ?? "No info")
                                        .bold()
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.triangle.branch")
                                        .foregroundColor(.black.opacity(0.5))

                                    Text(String(repo.forks))
                                        .bold()
                                        .frame(width: 50)
                                    
                                    Image(systemName: "eye.fill")
                                        .foregroundColor(.black.opacity(0.5))
                                    
                                    Text(String(repo.watchers))
                                        .frame(width: 50)
                                        .bold()
                                    
                                }
                            }
                        }
                        .frame(height: 100)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }
                }
                
            }
            .navigationTitle("Repositories")
        }
        .onAppear {
            isLoading = true
            viewModel.fetchRequestRepos(userLink: "https://api.github.com/users/\(user.login)/repos")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                isLoading = false
            }
        }
    }
}
