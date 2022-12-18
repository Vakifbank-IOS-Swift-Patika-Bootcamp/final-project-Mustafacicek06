//
//  FavoritesViewModel.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 18.12.2022.
//

import Foundation


protocol FavoritesViewModelProtocol {
    var delegate: FaveoritesViewModelDelegate? {get set}
    func getGamesFromDB()
    func getGameCount() -> Int
    func getGame(at index: Int) -> Favorites?
    func getGameID(at index: Int) -> Int?
}

protocol FaveoritesViewModelDelegate: AnyObject {
    func gamesLoaded()
    func preFetch()
    func postFetch()
    func gamesFailed(error: Error)
}

final class FavoritesViewModel: FavoritesViewModelProtocol{
    weak var delegate: FaveoritesViewModelDelegate?
    
    private var favoriteGames: [Favorites]?
    
    func getGamesFromDB() {
        favoriteGames = CoreDataManager.shared.getGames()
        print(favoriteGames?.count ?? 0)
    }
    
    func getGameCount() -> Int {
        favoriteGames?.count ?? 0
    }
    
    func getGame(at index: Int) -> Favorites? {
        favoriteGames?[index]
    }
    
    func getGameID(at index: Int) -> Int? {
        print( favoriteGames?[index].id ?? 0)
        return Int(favoriteGames?[index].id ?? 0)
    }
}
