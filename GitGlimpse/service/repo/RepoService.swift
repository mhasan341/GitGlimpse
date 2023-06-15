//
//  RepoService.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import Foundation
/// protocol for repositoryDetailsVC
protocol RepoService {
    /// To search for an array of GGRepo objects using the given query
    /// - Parameter query:string to search
    /// - Returns: a GGRepo array
    func getRepositories(for query: String, page: Int) async throws -> [GGRepo]
    
    /// To get  all commits for the user of the repo
    /// - Parameter url: url for the commits
    /// - Returns: array of GGRepo
    func getCommitsForRepo(for url: String) async throws -> [CommitHistory]
}
