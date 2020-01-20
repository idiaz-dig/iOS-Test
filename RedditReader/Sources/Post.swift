//
//  Post.swift
//  RedditReader
//
//  Created by Ignacio Diaz on 20/01/2020.
//  Copyright © 2020 Ignacio Diaz. All rights reserved.
//

import Foundation

struct Post {
    var author: String
    var date: Date
    var text: String
    var imageURL: String?
    var numberOfComments: Int
}
