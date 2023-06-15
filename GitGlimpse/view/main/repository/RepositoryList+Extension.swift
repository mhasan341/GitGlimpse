//
//  RepositoryList+Extension.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import UIKit

extension RepositoryListVC: UICollectionViewDelegate, UISearchResultsUpdating {
    // detects if user reached to the bottom
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // how far I scrolled?
        let offsetY = scrollView.contentOffset.y
        // the entire size of the scrollView
        let contentHeight = scrollView.contentSize.height
        // height of screen
        let height = scrollView.frame.size.height

        if offsetY > (contentHeight - height){

            guard hasMoreRepo, !isLoading else {return}

            page += 1
            getRepoList()

        }
    }

    // updates the collection view
    func updateSearchResults(for searchController: UISearchController){
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isSearching = false
            filteredRepo.removeAll()
            invalidateCollectionView(with: repos)
            return
        }
        // we're still searching
        isSearching = true
        filteredRepo = repos.filter{ $0.name.lowercased().contains(filter.lowercased())}

        invalidateCollectionView(with: filteredRepo)

    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let repo = isSearching ? filteredRepo[indexPath.item] : repos[indexPath.item]
        /// Injecting dependency
        let vc = RepositoryDetailVC(repo: repo)
        let navController = UINavigationController(rootViewController: vc)
        present(navController, animated: true)

    }
}
