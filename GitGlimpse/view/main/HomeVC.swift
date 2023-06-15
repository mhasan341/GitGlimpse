//
//  HomeVC.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import UIKit

class HomeVC: UIViewController {

    let logoImageView = UIImageView()
    let reponameTF = GFTextField()
    let searchButton = GFButton(title: "Search Repos", withBackgroundColor: .systemBlue)
    var logoImageViewTopContraints: NSLayoutConstraint!

    var isQueryEntered: Bool {
        !reponameTF.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        reponameTF.delegate = self

        // Do any additional setup after loading the view.
        configureLogoImageView()
        configureTextField()
        configureSearchButton()

        createDismissKeyboardTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        reponameTF.text?.removeAll()
    }

    /// dismissed the keyboard on outside touch
    func createDismissKeyboardTapGesture(){
        let tg = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tg)
    }

    func configureLogoImageView(){

        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.headerImage

        let topContraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20: 80
        logoImageViewTopContraints = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topContraintConstant)
        logoImageViewTopContraints.isActive = true

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    func configureTextField(){
        view.addSubview(reponameTF)

        NSLayoutConstraint.activate([
            reponameTF.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            reponameTF.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            reponameTF.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            reponameTF.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configureSearchButton(){
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(openRepoListVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)

        ])
    }

    @objc func openRepoListVC(){

        guard isQueryEntered else{
            presentGGAlertOnMainThread(withTitle: "Warning!", message: "This field can't be empty", buttonTitle: "Got it!")
            return
        }

        let vc = RepositoryListVC(query: reponameTF.text!)

        reponameTF.resignFirstResponder()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        reponameTF.resignFirstResponder()
        openRepoListVC()
        return true
    }
}
