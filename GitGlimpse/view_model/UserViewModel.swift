//
//  UserViewModel.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import Foundation

class UserViewModel {
    /// this one returns data to parent vc
    weak var delegate: UserOutput?
    weak var imageDelegate: ImageUpdateService?

    private var username: String
    
    /// conformed by NetworkManager
    private var service: UserService
    private let imageService: ImageService

    init(username: String, service: UserService, imageService: ImageService) {
        self.username = username
        self.service = service
        self.imageService = imageService
    }

    func fetchUserDetails(){
        Task {
            do {
                let user = try await service.getUserInfo(for: username)
                delegate?.updateUI(with: user)

            } catch {

            }
        }
    }

    func downloadImage(for imageUrl: String){
        imageService.downloadImage(urlString: imageUrl) { [weak self] image in
            guard let image = image else {
                self?.imageDelegate?.updateImage(with: Images.placeholder)
                return
            }

            self?.imageDelegate?.updateImage(with: image)

        }
    }

    func fetchUserPublicRepos(){
        Task {
            do {
                let repos = try await service.getUserPublicRepos(for: "https://api.github.com/users/\(username)/repos")
                delegate?.updateUserRepo(with: repos)

            } catch {

            }
        }
    }
    

}
