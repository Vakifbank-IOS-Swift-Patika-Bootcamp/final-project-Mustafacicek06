//
//  FavoritesViewController.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 18.12.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    private var viewModel: FavoritesViewModelProtocol = FavoritesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        componentsRegister()
        setComponentsLayout()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getGamesFromDB()
        self.collectionView.reloadData()
    }
    
    private func configure() {
        viewModel.delegate = self
        viewModel.getGamesFromDB()
    }
    
    private func setComponentsLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 120)
     
        collectionView.collectionViewLayout = layout
    }
    
    private func componentsRegister() {
        collectionView.register(GameDetailCollectionViewCell.nib() , forCellWithReuseIdentifier: GameDetailCollectionViewCell.identifier)
    }

   

}

extension FavoritesViewController: FaveoritesViewModelDelegate {
    func gamesLoaded() {
        self.collectionView.reloadData()
    }
    
    func preFetch() {
        
    }
    
    func postFetch() {
        
    }
    
    func gamesFailed(error: Error) {
        AlertManager.shared.showAlert(with: .wrongInput, localizeDescription: "Error.", title: "Error")

    }
    
    
}

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: GameDetailViewController.self)) as? GameDetailViewController else { return }
        detailVC.selectedGameIndex = viewModel.getGameID(at: indexPath.row)
                 self.navigationController?.pushViewController(detailVC, animated: true)
        }
    
    
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getGameCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameDetailCollectionViewCell.identifier, for: indexPath) as? GameDetailCollectionViewCell, let model = viewModel.getGame(at: indexPath.row) else {return UICollectionViewCell()}
        
        cell.configure(model: model)
        
        return cell
    }
    
    
}
