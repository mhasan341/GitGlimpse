//
//  CommitHistory.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import Foundation

// MARK: - CommitHistory
struct CommitHistory: Codable, Hashable{

    let sha: String
    let commit: Commit?

    func hash(into hasher: inout Hasher) {
        hasher.combine(sha)
    }

    static func == (lhs: CommitHistory, rhs: CommitHistory) -> Bool {
        lhs.sha == rhs.sha
    }

}


// MARK: - Commit
struct Commit: Codable {
    let author, committer: Author
}

// MARK: - CommitAuthor
struct Author: Codable {
    let name, email: String
}
