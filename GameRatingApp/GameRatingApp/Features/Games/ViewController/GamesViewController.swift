//
//  ViewController.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 10.12.2022.
//

import UIKit

final class GamesViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    

    private var viewModel: GamesViewModelProtocol = GamesViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureDelegates()
        componentsRegister()
        setComponentsLayout()
    }
    
    // MARK: Private functions
    
    private func configureDelegates() {

        viewModel.delegate = self
        viewModel.fetchGames()
        
    }
    
    private func setComponentsLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 200)
     
        collectionView.collectionViewLayout = layout
    }
    
    private func componentsRegister() {
        collectionView.register(GameCollectionViewCell.nib() , forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
    }
}

extension GamesViewController: GamesViewModelDelegate {
    func gamesLoaded() {
        self.collectionView.reloadData()
        print("cagirildi")
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.identifier, for: indexPath) as? GameCollectionViewCell, let model = viewModel.getGame(at: indexPath.row) else {return UICollectionViewCell()}
        
        cell.configure(model: model)
      
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        /*
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: CharacterDetailViewController.self)) as? CharacterDetailViewController else { return }
        detailVC.selectedCharacter = allCharacters?[indexPath.row]
                 self.navigationController?.pushViewController(detailVC, animated: true)
        }
         */
   
    }
    
    
}
