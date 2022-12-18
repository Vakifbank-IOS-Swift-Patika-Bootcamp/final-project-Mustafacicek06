//
//  GameDetailViewModel.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 17.12.2022.
//

import Foundation



protocol  GameDetailViewModelProtocol {
    var delegate: GameDetailViewModelDelegate? {get set}
    func fetchGameDetail(id: Int)
}

protocol GameDetailViewModelDelegate: AnyObject {
    func gameLoaded()
    func preFetch()
    func postFetch()
    func gameFailed(error: Error)
}

final class GameDetailViewModel: GameDetailViewModelProtocol {
    var delegate: GameDetailViewModelDelegate?
    private var selectedGame: GameDetail?

    
    func fetchGameDetail(id: Int) {
        self.delegate?.preFetch()
        GameClient.getGameDetail(movieId: id) { [weak self] game, error in
            
            guard let self = self else {return}
            if let error { self.delegate?.gameFailed(error: error) }
            self.selectedGame = game
            print(game?.name)
            self.delegate?.gameLoaded()
            self.delegate?.postFetch()
            
            
        }
       
    }
    
    func addFavorite() {
        guard let selectedGame = selectedGame else { return }
        CoreDataManager.shared.saveGame(id: Int64(selectedGame.id ?? 0), imageURL: selectedGame.backgroundImage ?? "" , gameName: selectedGame.name ?? "", rating: selectedGame.rating ?? 0 , released: selectedGame.released ?? "")
    }
    
    func getGame() -> GameDetail? {
        selectedGame
    }
    
    
}
