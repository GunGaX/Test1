//
//  UsersViewModel.swift
//  Test
//
//  Created by Dmytro Savka on 21.03.2023.
//

import Foundation
import Combine
import CoreData

class UsersViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var repos: [Repo] = []
    
    private var bag = Set<AnyCancellable>()
    
    func fetchRequestUsers() {
        
        if let url = URL(string: "https://api.github.com/users") {
            URLSession
                .shared
                .dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .tryMap({ data in
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let users = try? decoder.decode([User].self, from: data) {
                        self.users = users
                    } else {}
                    return self.users
                })
                .sink { res in
                    print(res)
                } receiveValue: { [weak self] users in
                    self?.users = users
                }
                .store(in: &bag)
        }
    }
    
    
    func fetchRequestRepos(userLink: String) {
        
        if let url = URL(string: userLink) {
            URLSession
                .shared
                .dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .tryMap({ data in
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let repos = try? decoder.decode([Repo].self, from: data) {
                        self.repos = repos
                    } else {}
                    return self.repos
                })
                .sink { res in
                    print(res)
                } receiveValue: { [weak self] repos in
                    self?.repos = repos
                }
                .store(in: &bag)
        }
    }
    
    
    @Published var savedUsers: [UserEntity] = []
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error while loading data!!! \(error)")
            }
            
        }
        
        fetchUsersData()
    }
    
    func fetchUsersData() {
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        
        do {
            savedUsers = try container.viewContext.fetch(request)
        } catch let error {
            print("Error while fetching data!!! \(error)")
        }
    }
    
    func addUserToSaved(user: User) {
        for existingUser in savedUsers {
            if existingUser.id == user.id { return }
        }
        
        let newUser = UserEntity(context: container.viewContext)
        
        newUser.id = user.id
        newUser.login = user.login
        newUser.avatarUrl = user.avatarUrl
        newUser.reposUrl = user.reposUrl
        
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchUsersData()
        } catch let error {
            print("Error while saving data!!! \(error)")
        }
    }
    
    func deleteData(userID: Int64) {
        var userToDelete: UserEntity?
        for savedUser in savedUsers {
            if savedUser.id == userID {
                userToDelete = savedUser
            }
        }
        container.viewContext.delete(userToDelete!)
        saveData()
    }
    
    func isSaved(user: User) -> Bool{
        for savedUser in savedUsers {
            if savedUser.id == user.id {
                return true
            }
        }
        return false
    }
    
    func userByID(userID: Int64) -> User? {
        for user in users {
            if user.id == userID {
                return user
            }
        }
        return nil
    }
    
    
    
}
