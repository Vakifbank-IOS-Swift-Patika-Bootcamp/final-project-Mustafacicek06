//
//  GameCollectionViewCell.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 16.12.2022.
//

import UIKit
import Kingfisher

class GameCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var gameNameLabel: UILabel!
    @IBOutlet private var rateLabel: UILabel!
    @IBOutlet private var releaseDateLabel: UILabel!
    
    
    static let identifier = "CharacterCollectionViewCell"
    private var imageURL: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    

    public func configure(url imageURL: String , gameNameLabel: String, rate: Double, releaseDate: String){
        setUIAttributes()
        self.gameNameLabel.text = gameNameLabel
        self.rateLabel.text = "\(rate)"
        self.releaseDateLabel.text = releaseDate
        self.imageURL = imageURL
        guard let url = URL(string: imageURL) else { return }
        self.imageView.kf.setImage(with: url)
    }
    private func setUIAttributes() {
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = CGFloat(10)
    }
    // if you using nib, recommended this
    static func nib() -> UINib {
        return UINib(nibName: GameCollectionViewCell.identifier, bundle: nil)
    }

}
