//
//  GGStatInfoView.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import UIKit

/// to be used in repo details view
class GGStatInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure(){
        
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            countLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 8),
            countLabel.heightAnchor.constraint(equalToConstant: 18),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    // this function sets the card image and text based on the input value
    func set(statInfoType: StatInfoType, withCount count: Int){
        
        switch statInfoType {
            case .starCount:
                symbolImageView.image = UIImage(systemName: "star")
                titleLabel.text = "Stars"
                
            case .forkCount:
                symbolImageView.image = UIImage(systemName: "arrow.triangle.branch")
                titleLabel.text = "Forks"
                
            case .issueCount:
                symbolImageView.image = UIImage(systemName: "exclamationmark.circle")
                titleLabel.text = "Issues"
                
                
        }
        
        countLabel.text = String(count)
        
    }
}
