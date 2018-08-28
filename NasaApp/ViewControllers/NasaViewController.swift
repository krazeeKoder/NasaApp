//
//  NasaViewController.swift
//  NasaApp
//
//  Created by Anthony Tulai on 2018-08-28.
//  Copyright © 2018 Anthony Tulai. All rights reserved.
//

import UIKit

class NasaViewController: UIViewController {
    @IBOutlet weak var dailyImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dailyImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var presenter: NasaPresenter?
    
    deinit {
        presenter = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureActivityIndicator()
        presenter = NasaPresenter(view: self)
        presenter?.configureForLaunch()
    }
    
    //MARK: - IBActions
    
    @IBAction func imagePressed(_ sender: UITapGestureRecognizer) {
        presenter?.handleImagePress()
    }
    
    //MARK: - Configuration Methods
    
    private func configureActivityIndicator() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.activityIndicatorViewStyle = .gray
        self.activityIndicator.hidesWhenStopped = true
    }
}

extension NasaViewController: NasaViewProtocol {
    //MARK: - NASAViewProtocol Methods
    func update(pictureOfTheDay picture: Data?, title: String?) {
        self.activityIndicator.stopAnimating()
        if let picture = picture, let title = title {
            self.dailyImageView.image = UIImage(data: picture)
            self.titleLabel.text = title
        }
    }
    
    func update(errorMessage: String, title: String) {
        self.activityIndicator.stopAnimating()
        self.showGenericErrorAlert(message: errorMessage, title: title)
    }
    
    func displayFullScreen() {
        self.dailyImageViewHeightConstraint.constant = self.view.frame.height
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
            self.titleLabel.alpha = 0
        }
    }
    
    func displayHalfScreen() {
        self.dailyImageViewHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
            self.titleLabel.alpha = 1.0
        }
    }
}



