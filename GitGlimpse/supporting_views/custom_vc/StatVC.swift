//
//  StatVC.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import UIKit

/// for repo details vc, this one holds the stat related to count
class StatVC: UIViewController {

    var repo: GGRepo!

    let stackView = UIStackView()
    let statInfoOne = GGStatInfoView()
    let statInfoTwo = GGStatInfoView()
    let statInfoThree = GGStatInfoView()

    init(repo: GGRepo!) {
        super.init(nibName: nil, bundle: nil)
        self.repo = repo
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureBackgroundView()

        layoutUI()
        configureStackView()

        statInfoOne.set(statInfoType: .starCount, withCount: repo.stargazersCount)
        statInfoTwo.set(statInfoType: .forkCount, withCount: repo.forks)
        statInfoThree.set(statInfoType: .issueCount, withCount: repo.openIssuesCount)
    }

    private func configureBackgroundView() {
        view.layer.cornerRadius = 10
        view.backgroundColor    = .secondarySystemBackground
    }

    private func configureStackView() {
        stackView.axis          = .vertical
        stackView.distribution  = .equalSpacing
        stackView.spacing = 30

        stackView.addArrangedSubview(statInfoOne)
        stackView.addArrangedSubview(statInfoTwo)
        stackView.addArrangedSubview(statInfoThree)
    }


    private func layoutUI() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 16

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
        ])

    }

}
