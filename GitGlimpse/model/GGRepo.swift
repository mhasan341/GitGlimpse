//
//  GGRepo.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-14.
//

import Foundation

struct GGRepo: Codable {
    let id: Int
    let name: String
    let owner: Owner
    let stargazersCount: Int
    let forks: String
    let openIssuesCount: Int
}

struct Owner: Codable {
    let login: String
    let avatarUrl: String
}
