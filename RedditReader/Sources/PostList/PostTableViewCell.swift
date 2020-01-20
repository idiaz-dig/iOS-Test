//
//  PostTableViewCell.swift
//  RedditReader
//
//  Created by Ignacio Diaz on 20/01/2020.
//  Copyright © 2020 Ignacio Diaz. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var unreadStatusLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var dismissPostButton: UIButton!
}
