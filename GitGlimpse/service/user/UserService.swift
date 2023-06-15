//
//  UserService.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import Foundation
/// protocol for userInfoVC
protocol UserService {
    /// To get an user for the given username
    /// - Parameter username: username of the user to get
    /// - Returns: a GGUser object
    func getUserInfo(for username: String) async throws -> GGUser
    /// To get  all public repo for given username
    /// - Parameter username: username of the user
    /// - Returns: array of GGRepo
    func getUserPublicRepos(for url: String) async throws -> [GGRepo]
}
