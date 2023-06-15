//
//  GGUser.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-14.
//

import Foundation

struct GGUser: Codable{
    var name: String
    var login: String
    var avatarUrl: String
    var publicRepos: Int
    var followers: Int
    var following: Int
    var reposUrl: String = ""
}
