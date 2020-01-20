//
//  Post.swift
//  RedditReader
//
//  Created by Ignacio Diaz on 20/01/2020.
//  Copyright © 2020 Ignacio Diaz. All rights reserved.
//

import Foundation

struct Post: Codable {
    var author: String
    var date: TimeInterval
    var title: String
    var imageURL: String?
    var numberOfComments: Int

    enum CodingKeys: String, CodingKey {
        case data
        case author = "author_fullname"
        case date = "created"
        case title = "title"
        case imageURL = "thumbnail"
        case numberOfComments = "num_comments"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.author = try data.decode(String.self, forKey: .author)
        self.date = try data.decode(TimeInterval.self, forKey: .date)
        self.title = try data.decode(String.self, forKey: .title)
        self.imageURL = try data.decode(String.self, forKey: .imageURL)
        self.numberOfComments = try data.decode(Int.self, forKey: .numberOfComments)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var data = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        try data.encode(self.author, forKey: .author)
        try data.encode(self.date, forKey: .date)
        try data.encode(self.title, forKey: .title)
        try data.encode(self.imageURL, forKey: .imageURL)
        try data.encode(self.numberOfComments, forKey: .numberOfComments)
    }
}
