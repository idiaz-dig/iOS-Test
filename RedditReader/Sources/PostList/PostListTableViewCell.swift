//
//  PostListTableViewCell.swift
//  RedditReader
//
//  Created by Ignacio Diaz on 20/01/2020.
//  Copyright © 2020 Ignacio Diaz. All rights reserved.
//

import UIKit

class PostListTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var dismissPostButton: UIButton!
    @IBOutlet weak var unreadStatusLabel: UILabel!

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postImageViewWidthConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        dismissPostButton.setTitle("Dismiss Post", for: .normal)
    }
    
    func setup(with post: Post) {
        authorLabel.text = post.author
        postTitleLabel.text = post.title
        commentsLabel.text = "\(post.numberOfComments) comments"

        dateLabel.text = getElapsedTime(from: post.date)

        if let imageURL = post.imageURL {
            postImageViewWidthConstraint.constant = 70
            loadImage(with: imageURL)
        }
        else {
            postImageViewWidthConstraint.constant = 0
        }
    }
    
    private func getElapsedTime(from interval: TimeInterval) -> String {
        let initialDate = Date(timeIntervalSince1970: interval)
        let interval = Calendar.current.dateComponents([.hour], from: initialDate, to: Date())
        if let hour = interval.hour, hour > 0 {
            return "\(hour) \(hour == 1 ? "hour ago" : "hours ago")"
        }
        return "less than an hour ago"
    }

    private func loadImage(with url: String) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.postImageView.image = image
            }
        }.resume()
    }
}
