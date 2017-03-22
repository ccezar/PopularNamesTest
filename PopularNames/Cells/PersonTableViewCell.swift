//
//  PersonTableViewCell.swift
//  PopularNames
//
//  Created by Caio Cezar Lopes dos Santos on 3/19/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    var person: Person? {
        didSet {
            if let photoURL = person?.photo {
                photoImageView.downloadedFrom(link: photoURL)
            }
            
            nameLabel.text = person?.name ?? ""
            birthdayLabel.text = person?.birthdayFormatted() ?? ""
        }
    }
}
