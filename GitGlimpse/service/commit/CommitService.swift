//
//  CommitService.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import Foundation
/// protocol for commitListVC
protocol CommitService {
    /// To get  all commits for the user of the repo
    /// - Parameter url: url for the commits
    /// - Returns: array of GGRepo
    func getCommitsForRepo(for url: String) async throws -> [CommitHistory]
}
