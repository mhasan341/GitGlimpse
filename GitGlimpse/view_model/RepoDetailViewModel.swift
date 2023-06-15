//
//  RepoDetailViewModel.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import Foundation

class RepoDetailViewModel {
    
    /// this one returns data to parent vc
    weak var delegate: ImageUpdateService?

    /// conformed by ImageManager
    private let imageService: ImageService

    init(service: ImageService) {
        self.imageService = service
    }

    func downloadImage(for imageUrl: String){
        imageService.downloadImage(urlString: imageUrl) { [weak self] image in
            guard let image = image else {
                self?.delegate?.updateImage(with: Images.placeholder)
                return
            }

            self?.delegate?.updateImage(with: image)

        }
    }


}
