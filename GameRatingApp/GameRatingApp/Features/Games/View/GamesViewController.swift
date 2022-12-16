//
//  ViewController.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 10.12.2022.
//

import UIKit

final class GamesViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var allGames: [GameModel]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getAllGames()
        configureDelegates()
        componentsRegister()
    }
    
    // MARK: Private functions
    
    private func configureDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func componentsRegister() {
        collectionView.register(GameCollectionViewCell.nib() , forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
    }
    
    private func getAllGames() {
        GameClient.getAllGames { games, error in
            if let games = games {
                self.allGames = games
                self.collectionView.reloadData()
            }
            else {
                AlertManager.shared.showAlert(with: .wrongInput, localizeDescription: "Error", title: "Error")
            }
        }
    }

}

extension GamesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}

extension GamesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allGames?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.identifier, for: indexPath) as! GameCollectionViewCell
        cell.configure(url: allGames?[indexPath.row].backgroundImage ?? "" , gameNameLabel: allGames?[indexPath.row].name ?? "", rate: allGames?[indexPath.row].rating ?? 0, releaseDate: allGames?[indexPath.row].released ?? "")
        return cell
    }
}
