//
//  DetailViewController.swift
//  PopularNames
//
//  Created by Caio Cezar Lopes dos Santos on 3/19/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var person: Person?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var bioLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func loadData() {
        navigationItem.title = person?.name
        
        if let photoURL = person?.photo {
            photoImageView.downloadedFrom(link: photoURL)
        }
        
        if let bio = person?.bio {
            bioLabel.text = bio
            alphaView.isHidden = false
            bioLabel.isHidden = false
        } else {
            alphaView.isHidden = true
            bioLabel.isHidden = true
        }
    }
}
