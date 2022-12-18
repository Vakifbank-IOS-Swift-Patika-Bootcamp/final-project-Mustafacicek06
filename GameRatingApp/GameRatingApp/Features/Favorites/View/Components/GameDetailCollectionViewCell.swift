//
//  GameDetailCollectionViewCell.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 18.12.2022.
//

import UIKit

final class GameDetailCollectionViewCell: UICollectionViewCell {

   
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var gameNameLabel: UILabel!
    @IBOutlet private var rateLabel: UILabel!
    @IBOutlet private var releaseDateLabel: UILabel!
    
    
    static let identifier = "GameDetailCollectionViewCell"
    private var imageURL: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    

    public func configure(model: Favorites){
        
        setUIAttributes()
       self.gameNameLabel.text = model.gameName ?? ""
        self.rateLabel.text = "\(model.rating ?? 0)"
        self.releaseDateLabel.text = model.released
        self.imageURL = model.imageURL
        guard let url = URL(string: imageURL ?? "") else { return }
        self.imageView.kf.setImage(with: url)
    }
    private func setUIAttributes() {
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = CGFloat(10)
        
    }
    // if you using nib, recommended this
    static func nib() -> UINib {
        return UINib(nibName: GameDetailCollectionViewCell.identifier, bundle: nil)
    }

}
