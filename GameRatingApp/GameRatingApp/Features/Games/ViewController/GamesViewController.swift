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
    
    private var viewModel: GamesViewModelProtocol = GamesViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureDelegates()
        componentsRegister()
    }
    
    // MARK: Private functions
    
    private func configureDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
        viewModel.fetchGames()
    }
    
    private func componentsRegister() {
        collectionView.register(GameCollectionViewCell.nib() , forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
    }
}

extension GamesViewController: GamesViewModelDelegate {
    func gamesLoaded() {
        collectionView.reloadData()
    }
    
    func gamesFailed(error: Error) {
        AlertManager.shared.showAlert(with: .wrongInput, localizeDescription: "Error.", title: "Error")
    }
    
    
}

extension GamesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}

extension GamesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getGameCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.identifier, for: indexPath) as! GameCollectionViewCell
        cell.configure(url: allGames?[indexPath.row].backgroundImage ?? "" , gameNameLabel: allGames?[indexPath.row].name ?? "", rate: allGames?[indexPath.row].rating ?? 0, releaseDate: allGames?[indexPath.row].released ?? "")
        return cell
    }
}
