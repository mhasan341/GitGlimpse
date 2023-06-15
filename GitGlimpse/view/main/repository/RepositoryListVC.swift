//
//  RepositoryListVC.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import UIKit

class RepositoryListVC: UIViewController, RepoOutput {

    let viewModel: RepoViewModel

    var repositoryList: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, GGRepo>!

    var repos: [GGRepo] = []
    var filteredRepo: [GGRepo] = []

    /// for pagination of repository response, we fetch 50 items at a time
    var page = 1

    var hasMoreRepo = true
    var isSearching = false
    var isLoading = false

    init(query: String) {

        self.viewModel = RepoViewModel(query: query, service: NetworkManager())
        super.init(nibName: nil, bundle: nil)

        title = query
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        configureCollectionView()
        getRepoList()
        configureDataSource()
        configureSearchController()

        viewModel.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }


    func getRepoList(){
        showLoadingView()
        isLoading = true
        viewModel.fetchRepos(for: page)
    }

    func configureCollectionView(){
        repositoryList = UICollectionView(frame: view.bounds, collectionViewLayout: LayoutManager.createFlowLayout(in: view))
        view.addSubview(repositoryList)

        repositoryList.register(RepoCell.self, forCellWithReuseIdentifier: RepoCell.reuseId)

        repositoryList.delegate = self

    }


    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, GGRepo>(collectionView: repositoryList, cellProvider: { collectionView, indexPath, repo in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoCell.reuseId, for: indexPath) as! RepoCell

            cell.set(repository: repo)

            return cell

        })
    }

    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Type to filter.."
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
    }

    func updateUI(with repos: [GGRepo]) {
        self.hideLoadingView()
        self.isLoading = false

        if repos.isEmpty{
            DispatchQueue.main.async {
                self.showEmptyStateView(with: "No repository found for this query 😥", in: self.view)
                return
            }
        }

        // we've set the per page limit to 50 in NetworkManager, so if the result contains less, we know that there is no more result
        if repos.count < 50 {self.hasMoreRepo = false}
        self.repos.append(contentsOf: repos)
        self.invalidateCollectionView(with: self.repos)
    }

    ///Used to update the collection when new data is fetched or a filter is made
    func invalidateCollectionView(with repos: [GGRepo]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, GGRepo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(repos)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }

}
