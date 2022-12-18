//
//  FavoritesViewModel.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 18.12.2022.
//

import Foundation


protocol FavoritesViewModelProtocol {
    var delegate: FaveoritesViewModelDelegate? {get set}

}

protocol FaveoritesViewModelDelegate: AnyObject {
    func gamesLoaded()
    func preFetch()
    func postFetch()
    func gamesFailed(error: Error)
}

class FavoritesViewModel: <#super class#> {
    <#code#>
}
