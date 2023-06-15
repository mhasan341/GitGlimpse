//
//  UIViewController+Ext.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    /// present an alert to the calling VC
    func presentGGAlertOnMainThread(withTitle: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let vc = GFAlertVC(title: withTitle, message: message, buttonTitle: buttonTitle)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        }
    }

    /// shows a loading on the calling vc with alpha background
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0

        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }

        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])

        activityIndicator.startAnimating()
    }

    /// hides the loading view
    func hideLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }

    // called when no item is to display
    func showEmptyStateView(with message: String, in view: UIView){

        let emptyStateView = GGEmptyStateView(message: message)
        emptyStateView.frame = view.bounds

        view.addSubview(emptyStateView)

    }
}
