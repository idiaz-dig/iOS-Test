//
//  PostList.swift
//  RedditReader
//
//  Created by Ignacio Diaz on 20/01/2020.
//  Copyright © 2020 Ignacio Diaz. All rights reserved.
//

import Foundation

struct PostList: Codable {
    var posts: [Post]
    
    enum CodingKeys: String, CodingKey {
      case data
      case posts = "children"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.posts = try data.decode([Post].self, forKey: .posts)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var data = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        try data.encode(self.posts, forKey: .posts)
    }
}
