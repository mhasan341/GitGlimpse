//
//  RepoViewModel.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import Foundation

class RepoViewModel {

    /// this one returns data to parent vc
    weak var delegate: RepoOutput?
    private var searchQuery: String

    /// conformed by NetworkManager
    private let repoService: RepoService

    /// DI
    init(query: String, service: RepoService) {
        self.searchQuery = query
        self.repoService = service
    }

    /// fetches repository using the page number, paginated response
    func fetchRepos(for page: Int){
        Task {
            do {
                let items = try await repoService.getRepositories(for: searchQuery, page: page)
                delegate?.updateUI(with: items)

            } catch {

            }
        }

    }


}
