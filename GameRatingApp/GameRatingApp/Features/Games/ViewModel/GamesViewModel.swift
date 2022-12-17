//
//  GamesViewModel.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 17.12.2022.
//

import Foundation

protocol GamesViewModelProtocol {
    var delegate: GamesViewModelDelegate? {get set}
    func fetchGames()
    func getGameCount() -> Int
    func getGame(at index: Int) -> GameModel?
    
}

protocol GamesViewModelDelegate: AnyObject {
    
    func gamesLoaded()
    func gamesFailed(error: Error)
}


final class GamesViewModel: GamesViewModelProtocol {
    
    weak var delegate: GamesViewModelDelegate?
    private var games: [GameModel]?
    
    func fetchGames() {
        GameClient.getAllGames { [weak self] games, error in
            
            guard let self = self else {return}
            if let error = error {self.delegate?.gamesFailed(error: error)}
            self.games = games
            self.delegate?.gamesLoaded()
        }
    }
    
    func getGameCount() -> Int {
        games?.count ?? 0
    }
    
    func getGame(at index: Int) -> GameModel? {
        games?[index]
    }
}
