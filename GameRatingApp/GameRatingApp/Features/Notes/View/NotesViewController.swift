//
//  NotesViewController.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 18.12.2022.
//

import UIKit

class NotesViewController: UIViewController{
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    final var viewModel: NotesViewModelProtocol =  NotesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.square.fill"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addNewNote))
        navigationItem.title = "Add Notes -> "
        configure()
        componentsRegister()
        setComponentsLayout()
    }
    
    @objc func addNewNote() {
        
        performSegue(withIdentifier: "toAddNote", sender: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getNotesFromDB()
        self.collectionView.reloadData()
    }
    
    private func configure() {
        viewModel.delegate = self
        self.viewModel.getNotesFromDB()
    }
    
    private func setComponentsLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 120)
     
        collectionView.collectionViewLayout = layout
    }
    
    private func componentsRegister() {
        collectionView.register(NotesCollectionViewCell.nib() , forCellWithReuseIdentifier: NotesCollectionViewCell.identifier)
    }

  

}
extension NotesViewController: NotesViewModelDelegate {
    func dataLoaded() {
        
    }
    
    func dataFailed(error: Error) {
        
    }
    
}

extension NotesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getGameCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotesCollectionViewCell.identifier, for: indexPath) as? NotesCollectionViewCell, let model = viewModel.getGame(at: indexPath.row) else {return UICollectionViewCell()}
        
        cell.configure(model: model)
        
        return cell
    }
    
    
}

