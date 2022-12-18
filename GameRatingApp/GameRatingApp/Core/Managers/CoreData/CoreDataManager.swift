//
//  CoreDataManager.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 18.12.2022.
//

import CoreData
import UIKit


enum CoreDataKeys: String {
    case released
    case imageURL
    case gameName
    case rating
    case id
    case note
}

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
    }
    
    func saveGame(id: Int64, imageURL: String, gameName: String, rating: Double,released: String) -> Favorites? {
        let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: managedContext)!
        let game = NSManagedObject(entity: entity, insertInto: managedContext)
        game.setValue( id,forKeyPath: CoreDataKeys.id.rawValue)
        game.setValue(imageURL, forKeyPath: CoreDataKeys.imageURL.rawValue)
        game.setValue(gameName, forKeyPath: CoreDataKeys.gameName.rawValue)
        game.setValue(rating, forKeyPath: CoreDataKeys.rating.rawValue)
        game.setValue(released, forKeyPath: CoreDataKeys.released.rawValue)
        
        do {
            try managedContext.save()
            return game as? Favorites
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    
    func saveNote(game: GameModel, gameNote: String?) -> Notes? {
        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        note.setValue( game.id,forKeyPath: CoreDataKeys.id.rawValue)
        note.setValue(game.backgroundImage, forKeyPath: CoreDataKeys.imageURL.rawValue)
        note.setValue(game.name, forKeyPath: CoreDataKeys.gameName.rawValue)
        note.setValue(gameNote, forKeyPath: CoreDataKeys.note.rawValue)
       
        
        do {
            try managedContext.save()
            AlertManager.shared.showAlert(with: nil, localizeDescription: "Game saved successfully :)", title: "Saved Success")
            return note as? Notes
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func getGames() -> [Favorites] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
        
        do {
            let episodes = try managedContext.fetch(fetchRequest)
            return episodes as! [Favorites]
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func getNotes() -> [Notes] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Notes")
        
        do {
            let episodes = try managedContext.fetch(fetchRequest)
            return episodes as! [Notes]
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func deleteEpisode(deleteItemID: Int16) {
        getGames().forEach { game in
            print("\(game.id) delete id: \(game)")
            if game.id == deleteItemID {
                managedContext.delete(game)
                try! managedContext.save()
            }
        }
    }
     /*
    func updateEpisode(selectedEpisode: EpisodeNote, season: String, episodeNumber: String, episodeTitle: String, note: String ) {
        getEpisodes().forEach { episode in
            if episode.id == selectedEpisode.id {
        
              
                episode.setValue(Int(season), forKeyPath: CoreDataKeys.season.rawValue)
                episode.setValue(Int(episodeNumber), forKeyPath: CoreDataKeys.episode.rawValue)
                episode.setValue(episodeTitle, forKeyPath: CoreDataKeys.episodeTitle.rawValue)
                episode.setValue(Int8(note), forKeyPath: CoreDataKeys.note.rawValue)
                try! managedContext.save()
            
            }
        }
    }
      */
    
}
