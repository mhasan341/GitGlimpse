//
//  UserProfileVC.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import UIKit

class UserProfileVC: UIViewController, UserOutput, ImageUpdateService, UICollectionViewDelegate{

    var viewModel: UserViewModel

    let scrollView = UIScrollView()
    let contentView = UIView()

    let followerState = GFButton(title: "", withBackgroundColor: .systemBlue)
    let followingState = GFButton(title: "", withBackgroundColor: .systemCyan)

    var ownerImageView = GGImageView(frame: .zero)
    var ownerNameLabel = GFTitleLabel(textAlignment: .natural, fontSize: 20)

    //For repo list
    var repositoryList: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, GGRepo>!
    var listView = UIView()

    init(username: String) {
        self.viewModel = UserViewModel(username: username, service: NetworkManager(), imageService: ImageManager())
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton

        configureScrollView()
        layoutUI()
        viewModel.delegate = self
        viewModel.imageDelegate = self
        // calls to vm for fetching data for us
        viewModel.fetchUserDetails()
        viewModel.fetchUserPublicRepos()

        configureCollectionView()
        configureDataSource()
    }


    @objc func dismissVC(){
        dismiss(animated: true)
    }

    func configureScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        ])

    }

    func layoutUI(){

        let publicTitle = GFTitleLabel(textAlignment: .natural, fontSize: 18)
        publicTitle.text = "Public repositories"

        contentView.addSubview(ownerNameLabel)
        contentView.addSubview(ownerImageView)

        contentView.addSubview(followerState)
        contentView.addSubview(followingState)
        contentView.addSubview(listView)
        contentView.addSubview(publicTitle)

        listView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            ownerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ownerImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            ownerImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
            ownerImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),

            ownerNameLabel.topAnchor.constraint(equalTo: ownerImageView.bottomAnchor, constant: 8),
            ownerNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            followerState.topAnchor.constraint(equalTo: ownerNameLabel.bottomAnchor, constant: 8),
            followerState.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -8),
            followerState.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
            followerState.heightAnchor.constraint(equalToConstant: 40),

            followingState.topAnchor.constraint(equalTo: ownerNameLabel.bottomAnchor, constant: 8),
            followingState.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 8),
            followingState.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
            followingState.heightAnchor.constraint(equalToConstant: 40),

            publicTitle.topAnchor.constraint(equalTo: followerState.bottomAnchor, constant: 12),
            publicTitle.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),

            listView.topAnchor.constraint(equalTo: publicTitle.bottomAnchor, constant: 4),
            listView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            listView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            listView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 0)

        ])

        listView.layoutIfNeeded()
    }

    func configureCollectionView(){
        repositoryList = UICollectionView(frame: listView.bounds, collectionViewLayout: LayoutManager.createFlowLayout(in: listView))
        listView.addSubview(repositoryList)

        repositoryList.register(RepoCell.self, forCellWithReuseIdentifier: RepoCell.reuseId)

    }


    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, GGRepo>(collectionView: repositoryList, cellProvider: { collectionView, indexPath, repo in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoCell.reuseId, for: indexPath) as! RepoCell

            // we're hiding the image from this vc
            cell.set(repository: repo, shouldHideImage: true)

            return cell

        })
    }


    //MARK: Delegate Call
    func updateUI(with userInfo: GGUser) {

        DispatchQueue.main.async {
            self.ownerNameLabel.text = userInfo.name
            self.followerState.setTitle("\(userInfo.followers) followers", for: .normal)
            self.followingState.setTitle("\(userInfo.following) following", for: .normal)
        }

        viewModel.downloadImage(for: userInfo.avatarUrl)
    }

    func updateImage(with image: UIImage) {
        DispatchQueue.main.async {
            self.ownerImageView.image = image
        }
    }

    func updateUserRepo(with repos: [GGRepo]) {
        DispatchQueue.main.async { [weak self] in
            var snapshot = NSDiffableDataSourceSnapshot<Section, GGRepo>()
            snapshot.appendSections([.main])
            snapshot.appendItems(repos)
            self?.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }

}
