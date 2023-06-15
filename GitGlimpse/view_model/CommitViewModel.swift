//
//  CommitViewModel.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import Foundation

class CommitViewModel {

    var repo: GGRepo
    /// this one returns data to parent vc
    weak var delegate: CommitOutput?
    /// conformed by NetworkManager
    private var service: CommitService

    init(repo: GGRepo, service: CommitService) {
        self.repo = repo
        self.service = service
    }

    func fetchCommits(){
        Task {
            do {
                let commits = try await service.getCommitsForRepo(for: "https://api.github.com/repos/\(repo.owner.login)/\(repo.name)/commits?per_page=50")
                delegate?.updateUI(with: commits)

            } catch {

            }
        }
    }
}
