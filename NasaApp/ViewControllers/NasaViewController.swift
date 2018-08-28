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
    
    private var presenter: NasaPresenter?
    
    deinit {
        presenter = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NasaPresenter(view: self)
        presenter?.configureForLaunch()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func imagePressed(_ sender: UITapGestureRecognizer) {
        presenter?.handleImagePress()
    }
    
}

extension NasaViewController: NasaViewProtocol {
    func update(pictureOfTheDay picture: Data?, title: String?) {
        if let picture = picture, let title = title {
            self.dailyImageView.image = UIImage(data: picture)
            self.titleLabel.text = title
        }
    }
    
    func update(errorMessage: String, title: String) {
        self.showGenericErrorAlert(message: errorMessage, title: title)
    }
    
    func displayFullScreen() {
        print("Show Full Screen")
    }
}



