//
//  BaseViewController.swift
//  ExhibitSmart
//
//  Created by Asmaa Tarek on 10/05/2021.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    
    var containerView:UIView!
    
    
    func showLoadingView(){
        if containerView == nil {
            view.isUserInteractionEnabled = false
            containerView = UIView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(containerView)
            NSLayoutConstraint.activate([
                containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            containerView.backgroundColor = .clear
            
            let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: .ballSpinFadeLoader, color: UIColor.brown, padding: 0)
            
            containerView.addSubview(activityIndicator)
            
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            activityIndicator.startAnimating()
            containerView.updateConstraints()
        }
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.isUserInteractionEnabled = true
            if let _ = self.containerView {
                self.containerView.removeFromSuperview()
                self.containerView = nil
            }
        }
    }
    
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        DispatchQueue.main.async {[weak self] in
            self?.present(alert, animated: true)
        }
    }
}
