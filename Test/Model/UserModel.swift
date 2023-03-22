//
//  UserModel.swift
//  Test
//
//  Created by Dmytro Savka on 21.03.2023.
//

import Foundation

struct User: Codable, Equatable {
    let id: Int64
    let login: String
    let avatarUrl: String
    let reposUrl: String
}


struct Repo: Codable, Equatable {
    let id: Int
    let name: String
    let language: String?
    let watchers: Int
    let forks: Int
}
