//
//  DetailViewController.swift
//  RedditReader
//
//  Created by Ignacio Diaz on 20/01/2020.
//  Copyright © 2020 Ignacio Diaz. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postImageViewHeightConstraint: NSLayoutConstraint!

    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = post {
            titleTextView.text = post.title
            authorLabel.text = post.author

            postImageViewHeightConstraint.constant = 0
            if let imageURL = post.imageURL {
                loadImage(with: imageURL)
            }
        }
    }
    
    private func loadImage(with url: String) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) {

                DispatchQueue.main.async() {
                    self?.postImageView.image = image
                    self?.postImageViewHeightConstraint.constant = 250
                }
            }
        }.resume()
    }
}
