//
//  CommitCell.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import UIKit

class CommitCell: UICollectionViewCell {
    static let reuseId = "commitCell"
    
    let commitAuthor = GFTitleLabel(textAlignment: .natural, fontSize: 16)
    let commitSha = GFBodyLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// sets the essential value to the cell
    func set(commit: CommitHistory) {
        commitAuthor.text = "Author: \(commit.commit?.author.name ?? "Guest")"
        commitSha.text = "SHA: \(commit.sha)"
    }
    
    /// configuration
    private func configure(){
        
        addSubview(commitAuthor)
        addSubview(commitSha)
        
        backgroundColor = .systemGray6
        layer.cornerRadius = 10
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            
            commitAuthor.topAnchor.constraint(equalTo: topAnchor, constant: padding * 2),
            commitAuthor.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            commitAuthor.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            commitAuthor.heightAnchor.constraint(equalToConstant: 30),
            
            commitSha.topAnchor.constraint(equalTo: commitAuthor.bottomAnchor, constant: padding / 2),
            commitSha.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            commitSha.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            commitSha.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
}

