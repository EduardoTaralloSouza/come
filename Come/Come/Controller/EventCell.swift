//
//  InfoTableViewCell.swift
//  Come
//
//  Created by Eduardo Souza on 14/09/20.
//  Copyright © 2020 Eduardo Tarallo Souza. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var view: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4
    }

}
