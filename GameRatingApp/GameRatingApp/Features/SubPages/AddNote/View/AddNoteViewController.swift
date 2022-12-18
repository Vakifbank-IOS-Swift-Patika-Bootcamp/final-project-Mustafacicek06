//
//  AddNoteViewController.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 18.12.2022.
//

import UIKit

final class AddNoteViewController: UIViewController {

    @IBOutlet private weak var pickerView: UIPickerView!
    
    @IBOutlet private weak var noteText: UITextField!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet private weak var selectedGameLabel: UILabel!
    
    private var games: [GameModel]?
    
    private var selectedGame: GameModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        getGames()
    }
    
    private func configure() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func getGames() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        GameClient.getAllGames { [weak self] games, error in
            
            self?.games = games
            
            self?.pickerView.reloadAllComponents()
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
        }
    }
    

    @IBAction func saveButtonClicked(_ sender: Any) {
        guard let selectedGame = selectedGame else {return}
        CoreDataManager.shared.saveNote(game: selectedGame , gameNote: noteText.text)
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(popToRoot), userInfo: nil, repeats: false)

    }
    
    @objc func popToRoot() {
        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddNoteViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        games?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        games?[row].name ?? "mustafa"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGameLabel.text = games?[row].name
        selectedGameLabel.resignFirstResponder()
        games?.map({ game in
            if game.name == selectedGameLabel.text {
                selectedGame = game
            }
        })
        
    }
    
}
