//
//  CommitListVC.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import UIKit

class CommitListVC: UIViewController, CommitOutput {

    var viewModel: CommitViewModel
    var repo: GGRepo

    /// will hold the commits made to the repo
    var commitList: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, CommitHistory>!
    
    init(repo: GGRepo) {
        self.repo = repo
        self.viewModel = CommitViewModel(repo: repo, service: NetworkManager())
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        viewModel.delegate = self

        title = "Recent Commits"
        navigationController?.navigationBar.prefersLargeTitles = true

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton

        configureCollectionView()
        configureDataSource()


        viewModel.fetchCommits()

    }

    func configureCollectionView(){
        commitList = UICollectionView(frame: view.bounds, collectionViewLayout: LayoutManager.createFlowLayout(in: view))
        view.addSubview(commitList)
        commitList.register(CommitCell.self, forCellWithReuseIdentifier: CommitCell.reuseId)
    }


    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, CommitHistory>(collectionView: commitList, cellProvider: { collectionView, indexPath, commit in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommitCell.reuseId, for: indexPath) as! CommitCell

            cell.set(commit: commit)

            return cell

        })
    }

    @objc func dismissVC(){
        dismiss(animated: true)
    }

    //MARK: Delegate Call
    func updateUI(with commits: [CommitHistory]) {

        DispatchQueue.main.async { [weak self] in
            var snapshot = NSDiffableDataSourceSnapshot<Section, CommitHistory>()
            snapshot.appendSections([.main])
            snapshot.appendItems(commits)
            self?.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
}
