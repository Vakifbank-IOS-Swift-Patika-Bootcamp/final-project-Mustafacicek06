//
//  NotesCollectionViewCell.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 18.12.2022.
//

import UIKit

class NotesCollectionViewCell: UICollectionViewCell {

   
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var gameNameLabel: UILabel!
    
    @IBOutlet weak var noteLabel: UITextView!
    
    
    
    static let identifier = "NotesCollectionViewCell"
    private var imageURL: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    

    public func configure(model: Notes){
        
        setUIAttributes()
       self.gameNameLabel.text = model.gameName ?? ""
        self.noteLabel.text = model.note
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
        return UINib(nibName: NotesCollectionViewCell.identifier, bundle: nil)
    }

}
