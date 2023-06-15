//
//  NetworkManager.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-14.
//

import Foundation

/// Handles network requests and returns data
class NetworkManager: RepoService, UserService, CommitService{

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    let defaults = UserDefaults.standard

    init(){
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    /// To search for an array of GGRepo objects using the given query
    /// - Parameter query:string to search
    /// - Returns: a GGRepo array
    func getRepositories(for query: String, page: Int) async throws -> [GGRepo]{
        let endpoint = "\(GitUrls.searchRepoUrl)\(query)&page=\(page)&per_page=50"

        guard let url = URL(string: endpoint) else {
            throw GGError.invalidName
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw GGError.invalidResponse
            }

            let repositories = try decoder.decode(GitHubData.self, from: data)

            return repositories.items

        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }

        return []

    }

    /// To get an user for the given username
    /// - Parameter username: username of the user to get
    /// - Returns: a GGUser object
    func getUserInfo(for username: String) async throws -> GGUser{
        let endpoint = "\(GitUrls.getGitUser)\(username)"

        guard let url = URL(string: endpoint) else {
            throw GGError.invalidName
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GGError.invalidResponse
        }

        let user = try decoder.decode(GGUser.self, from: data)
        return user

    }

    /// To get  all public repo for given username
    /// - Parameter url: url for the repos
    /// - Returns: array of GGRepo
    func getUserPublicRepos(for url: String) async throws -> [GGRepo] {

        guard let url = URL(string: url) else {
            throw GGError.invalidName
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw GGError.invalidResponse
            }

            let repositories = try decoder.decode([GGRepo].self, from: data)
            return repositories

        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }

        return []

    }

    /// To get  all commits for the user of the repo
    /// - Parameter url: url for the commits
    /// - Returns: array of GGRepo
    func getCommitsForRepo(for url: String) async throws -> [CommitHistory] {
        guard let url = URL(string: url) else {
            throw GGError.invalidName
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw GGError.invalidResponse
            }

            let commits = try decoder.decode([CommitHistory].self, from: data)
            return commits

        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }

        return []
    }

}
