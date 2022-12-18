//
//  NotesViewController.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 18.12.2022.
//

import UIKit

class NotesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.square.fill"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addNewNote))
        navigationItem.title = "Add Notes -> "
    }
    
    @objc func addNewNote() {
        print("plus")
    }

  

}
