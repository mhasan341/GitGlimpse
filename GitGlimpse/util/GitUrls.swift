//
//  GitUrls.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-14.
//

import Foundation

/// contains url for getting different github data
struct GitUrls {
    /// searches for repository in github
    static let searchRepoUrl = "https://api.github.com/search/repositories?q="
    /// gets the user details from github
    static let getGitUser = "https://api.github.com/users/"
}

