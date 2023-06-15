//
//  RepoCell.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import UIKit

class RepoCell: UICollectionViewCell {
    static let reuseId = "repoCell"
    
    let repoImageView = GGImageView(frame: .zero)
    let reponameLabel = GFTitleLabel(textAlignment: .natural, fontSize: 16)
    let repoDescLabel = GFBodyLabel()
    
    let forkImage = UIImageView(image: UIImage(systemName: "arrow.triangle.branch"))
    let starImage = UIImageView(image: UIImage(systemName: "star"))
    
    let forkCountLabel = GFTitleLabel(textAlignment: .center, fontSize: 12)
    let starCountLabel = GFTitleLabel(textAlignment: .center, fontSize: 12)
    
    
    var imageService: ImageService!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageService = ImageManager()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// sets the essential value to the cell
    func set(repository: GGRepo) {
        reponameLabel.text = repository.name
        repoDescLabel.text = repository.description ?? "No Description Available"
        
        forkCountLabel.text = "\(repository.forks)"
        starCountLabel.text = "\(repository.stargazersCount)"
        
        imageService.downloadImage(urlString: repository.owner.avatarUrl) { [weak self] image in
            guard let self = self else{ return }
            
            DispatchQueue.main.async {
                self.repoImageView.image = image
            }
        }
    }
    
    /// configuration
    private func configure(){
        
        addSubview(repoImageView)
        addSubview(reponameLabel)
        addSubview(repoDescLabel)
        
        addSubview(forkImage)
        addSubview(starImage)
        addSubview(forkCountLabel)
        addSubview(starCountLabel)
        
        forkImage.translatesAutoresizingMaskIntoConstraints = false
        starImage.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemGray6
        layer.cornerRadius = 10
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            
            repoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            reponameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding * 2),
            reponameLabel.leadingAnchor.constraint(equalTo: repoImageView.trailingAnchor, constant: padding),
            reponameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            repoDescLabel.topAnchor.constraint(equalTo: reponameLabel.bottomAnchor, constant: padding / 2),
            repoDescLabel.leadingAnchor.constraint(equalTo: repoImageView.trailingAnchor, constant: padding),
            repoDescLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            forkCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            forkCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            forkImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            forkImage.trailingAnchor.constraint(equalTo: forkCountLabel.leadingAnchor, constant: -padding),
            
            starCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            starCountLabel.trailingAnchor.constraint(equalTo: forkImage.leadingAnchor, constant: -padding * 1.5),
            
            starImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            starImage.trailingAnchor.constraint(equalTo: starCountLabel.leadingAnchor, constant: -padding),
            
        ])
        
        if DeviceTypes.isiPad {
            repoImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
            repoImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
            repoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding * 2).isActive = true
        } else {
            repoImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            repoImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
            repoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        }
    }
    
}
