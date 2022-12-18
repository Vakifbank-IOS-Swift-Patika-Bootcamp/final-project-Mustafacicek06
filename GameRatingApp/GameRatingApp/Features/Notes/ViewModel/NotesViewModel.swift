//
//  NotesViewModel.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 18.12.2022.
//

import Foundation


protocol NotesViewModelProtocol {
    var delegate: NotesViewModelDelegate? {get set}
    func getNotesFromDB()
    func getGameCount() -> Int
    func getGame(at index: Int) -> Notes?
}

protocol NotesViewModelDelegate: AnyObject {
    func dataLoaded()
    func dataFailed(error: Error)
    
}

class NotesViewModel: NotesViewModelProtocol  {
    weak var delegate: NotesViewModelDelegate?
    
    private var gameNotes: [Notes]?
    
    func getNotesFromDB() {
        gameNotes = CoreDataManager.shared.getNotes()
        self.delegate?.dataLoaded()
    }
    
    func getGameCount() -> Int {
        gameNotes?.count ?? 0
    }
    
    func getGame(at index: Int) -> Notes? {
        gameNotes?[index]
    }
    
}
