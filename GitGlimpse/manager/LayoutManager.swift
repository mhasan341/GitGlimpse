//
//  LayoutManager.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import UIKit

struct LayoutManager {
    static func createFlowLayout(in view: UIView)-> UICollectionViewFlowLayout{
        
        let width = view.bounds.width
        let padding : CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth  = width - (padding * 2) - (minimumItemSpacing * 2)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: availableWidth, height: availableWidth / 3.5)
        
        return flowLayout
    }
}

