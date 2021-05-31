//
//  FRDataLoadingVC.swift
//  Forecastr
//
//  Created by Evan Butler on 5/31/21.
//

import UIKit

class FRDataLoadingVC: UIViewController {
    
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        // required b/c this is called from within the network closure
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
}
