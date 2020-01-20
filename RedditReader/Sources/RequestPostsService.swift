//
//  RequestPostsService.swift
//  RedditReader
//
//  Created by Ignacio Diaz on 20/01/2020.
//  Copyright © 2020 Ignacio Diaz. All rights reserved.
//

import Foundation

protocol RequestPostsServiceProtocol {
    func getPosts(_ completion: @escaping ([Post]) -> Void)
}

final class RequestPostsService: RequestPostsServiceProtocol {
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func getPosts(_ completion: @escaping ([Post]) -> Void) {
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "https://www.reddit.com/top.json") {
            urlComponents.query = "limit=50"

            guard let url = urlComponents.url else { return }

            dataTask = session.dataTask(with: url) { [weak self] data, response, error in
                defer {
                    self?.dataTask = nil
                }
                
                if error == nil,
                    self?.isResponseValid(response) ?? false,
                    let data = data,
                    let postList = try? JSONDecoder().decode(PostList.self, from: data) {
                    
                    DispatchQueue.main.async {
                        completion(postList.posts)
                    }
                }
                else {
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            }
            dataTask?.resume()
        }
    }

    private func isResponseValid(_ response: URLResponse?) -> Bool {
        guard let response = response as? HTTPURLResponse else { return false }
        return response.statusCode == 200
    }
}
