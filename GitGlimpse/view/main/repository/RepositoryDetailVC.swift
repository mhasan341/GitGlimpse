//
//  RepositoryDetailVC.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import UIKit

class RepositoryDetailVC: UIViewController, ImageUpdateService {

    var repo: GGRepo
    var viewModel: RepoDetailViewModel

    var ownerImageView = GGImageView(frame: .zero)
    var repoTitleLabel = GFTitleLabel(textAlignment: .natural, fontSize: 20)
    var usernameLabel = GFBodyLabel()
    var descriptionLabel = GFBodyLabel()

    let scrollView = UIScrollView()
    let contentView = UIView()

    let statsView = UIView()

    let commitButton = GFButton(title: "See Commits", withBackgroundColor: .systemBlue)

    init(repo: GGRepo) {
        self.repo = repo
        self.viewModel = RepoDetailViewModel(service: ImageManager())
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

        // Do any additional setup after loading the view.
        configureScrollView()
        layoutUI()
        setRepoDetails()

        viewModel.delegate = self

        // Making the avatar image tappable and setting a gesture
        ownerImageView.isUserInteractionEnabled = true
        let tg = UITapGestureRecognizer(target: self, action: #selector(didTappedUser))
        self.ownerImageView.addGestureRecognizer(tg)


        // to see commits
        commitButton.addTarget(self, action: #selector(didTappedCommits), for: .touchUpInside)

    }

    func setRepoDetails(){
        configureStatVC(repo: repo)
        viewModel.downloadImage(for: repo.owner.avatarUrl)
        repoTitleLabel.text = repo.name
        usernameLabel.text = "creator: \(repo.owner.login)"
        descriptionLabel.text = repo.description ?? "No Description Available"
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

    private func configureStatVC(repo: GGRepo){
        DispatchQueue.main.async {
            let statVC = StatVC(repo: repo)
            self.add(childVC: statVC, to: self.statsView)
        }
    }

    func layoutUI(){

        let desL = GFTitleLabel(textAlignment: .natural, fontSize: 14)
        desL.text = "Description"

        contentView.addSubview(statsView)
        contentView.addSubview(ownerImageView)
        contentView.addSubview(repoTitleLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(desL)
        contentView.addSubview(commitButton)

        statsView.translatesAutoresizingMaskIntoConstraints = false

        descriptionLabel.numberOfLines = 0


        NSLayoutConstraint.activate([

            ownerImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            ownerImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            ownerImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
            ownerImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),

            repoTitleLabel.topAnchor.constraint(equalTo: ownerImageView.bottomAnchor, constant: 16),
            repoTitleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            repoTitleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: 8),

            usernameLabel.topAnchor.constraint(equalTo: repoTitleLabel.bottomAnchor, constant: 8),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            desL.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 30),
            desL.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            descriptionLabel.topAnchor.constraint(equalTo: desL.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),

            statsView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            statsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            statsView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
            statsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 110),

            commitButton.bottomAnchor.constraint(equalTo: ownerImageView.bottomAnchor),
            commitButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            commitButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
            commitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    /// adds a child vc to containerView, helpful when using multiple vc in one screen
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    func updateImage(with image: UIImage) {
        DispatchQueue.main.async {
            self.ownerImageView.image = image
        }
    }

    ///to see user profile
    @objc func didTappedUser() {
        let vc = UserProfileVC(username: repo.owner.login)
        let navController = UINavigationController(rootViewController: vc)
        present(navController, animated: true)
    }

    /// to see the list of commits to this repo
    @objc func didTappedCommits(){
        let vc = CommitListVC(repo: repo)
        let navController = UINavigationController(rootViewController: vc)
        present(navController, animated: true)
    }

}
