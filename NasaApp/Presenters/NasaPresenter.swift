//
//  NasaPresenter.swift
//  NasaApp
//
//  Created by Anthony Tulai on 2018-08-28.
//  Copyright © 2018 Anthony Tulai. All rights reserved.

import Foundation

protocol NasaViewProtocol {
    func update(pictureOfTheDay picture: Data?, title: String?)
    func update(errorMessage: String, title: String)
    func displayFullScreen()
}

class NasaPresenter {
    private var view: NasaViewProtocol?

    init(view: NasaViewProtocol?) {
        self.view = view
    }

    func configureForLaunch() {
        updateDailyPicture()
    }
    
    func handleImagePress() {
        view?.displayFullScreen()
    }
    
    private func updateDailyPicture() {
        DataManager.shared.updateDailyImage { (success) in
            guard let view = self.view else { return }
            if success {
                guard let imageURLString = DataManager.shared.nasaDailyUpdateInfo?.hdurl, let imageURL = URL(string: imageURLString) else {
                    view.update(errorMessage: Constants.Errors.failedToFetchDailyImageMessage, title: Constants.Errors.failedToFetchDailyImageTitle)
                    return
                    
                }
                let title = DataManager.shared.nasaDailyUpdateInfo?.title
                do {
                    let imageData = try Data(contentsOf: imageURL)
                    view.update(pictureOfTheDay: imageData, title: title)
                } catch {
                    view.update(errorMessage: Constants.Errors.failedToFetchDailyImageMessage, title: Constants.Errors.failedToFetchDailyImageTitle)
                }
            } else {
                view.update(errorMessage: Constants.Errors.failedToFetchDailyImageMessage, title: Constants.Errors.failedToFetchDailyImageTitle)
            }
        }
    }
}
