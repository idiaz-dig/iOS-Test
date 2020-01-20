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
    private lazy var postsService = RequestPostsService()
    
    // MARK:- PostListViewControllerListener

    func fetchData(_ completion: @escaping (() -> Void)) {
        postsService.getPosts { [weak self] (posts) in
            self?.posts = posts
            completion()
        }
    }
    
    func getNumberOfPosts() -> Int {
        return posts.count
    }

    func getPost(by index: Int) -> Post? {
        return posts[safe: index]
    }
}
