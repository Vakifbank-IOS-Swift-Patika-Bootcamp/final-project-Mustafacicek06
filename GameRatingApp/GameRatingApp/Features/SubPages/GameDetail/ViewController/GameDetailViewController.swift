//
//  GameDetailViewController.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 17.12.2022.
//

import UIKit

final class GameDetailViewController: UIViewController {
    
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var imageViewFirst: UIImageView!
    @IBOutlet private weak var imageViewSecond: UIImageView!
    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var directedByLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    
    @IBOutlet weak var descriptionText: UITextView!
    
    var favoriteButtonItem: UIBarButtonItem?
      var isFavorite: Bool = false
    var favoriteImage: UIImage
    {
        return UIImage(systemName: "heart" + (isFavorite ? ".fill" : "")) ?? UIImage()
    }
    
    
    var viewModel: GameDetailViewModel = GameDetailViewModel()
    var selectedGameIndex: Int?
    var game: GameDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchGameDetail(id: selectedGameIndex ?? 0)
        favoriteButtonItem = UIBarButtonItem(image: favoriteImage,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(toggleFavorite))
        navigationItem.rightBarButtonItem = favoriteButtonItem
    }
    
    @objc private func toggleFavorite()
    {
        isFavorite = !isFavorite
        favoriteButtonItem?.image = favoriteImage
        viewModel.addFavorite()
    }
    private func configure() {
        self.game = viewModel.getGame()
        gameNameLabel.text = game?.name
        releaseDateLabel.text = game?.released
        directedByLabel.text = game?.publishers?[0].name
        rateLabel.text = "\(game?.rating ?? 0)"
        descriptionText.text = game?.descriptionRaw
        
        let imageURL = game?.backgroundImage
        guard let url = URL(string: imageURL ?? "") else { return }
        self.imageViewFirst.kf.setImage(with: url)
        
        let imageURLSecond = game?.backgroundImageAdditional
        guard let url = URL(string: imageURLSecond ?? "") else { return }
        self.imageViewSecond.kf.setImage(with: url)
       
    }

}

extension GameDetailViewController: GameDetailViewModelDelegate {
    func gameLoaded() {
        configure()
    }
    
    func gameFailed(error: Error) {
        AlertManager.shared.showAlert(with: .wrongInput, localizeDescription: "Alert", title: "Error")
    }
    
  
    func preFetch() {
 
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        
   
    }
    func postFetch() {
 
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        

    }
    
    
}
