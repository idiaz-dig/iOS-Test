//
//  PostListViewModel.swift
//  RedditReader
//
//  Created by Ignacio Diaz on 20/01/2020.
//  Copyright © 2020 Ignacio Diaz. All rights reserved.
//

import Foundation

final class PostListViewModel: PostListViewControllerListener {

    private var posts = [Post]()
    
    // MARK:- PostListViewControllerListener
    
    func getNumberOfPosts() -> Int {
        return posts.count
    }

    func getPost(by index: Int) -> Post? {
        return posts[safe: index]
    }
}
