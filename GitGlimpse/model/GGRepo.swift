//
//  GGRepo.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-14.
//

import Foundation

struct GGRepo: Codable, Hashable {
    var id: Int = UUID().hashValue
    var name: String = ""
    var description: String?
    var owner: Owner
    var stargazersCount: Int = 0
    var forks: Int = 0
    var openIssuesCount: Int = 0

    static func == (lhs: GGRepo, rhs: GGRepo) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// Define a custom struct for the JSON data
struct GitHubData: Codable {
    let items: [GGRepo]
}

struct Owner: Codable {
    let login: String
    let avatarUrl: String
}
