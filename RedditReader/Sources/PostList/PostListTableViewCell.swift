//
//  PostListTableViewCell.swift
//  RedditReader
//
//  Created by Ignacio Diaz on 20/01/2020.
//  Copyright © 2020 Ignacio Diaz. All rights reserved.
//

import UIKit

protocol PostListTableViewCellListener: class {
    func dismissPostButtonTapped(at cell: UITableViewCell)
}

class PostListTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var dismissPostButton: UIButton!
    @IBOutlet weak var unreadStatusLabel: UILabel!

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postImageViewWidthConstraint: NSLayoutConstraint!

    weak var listener: PostListTableViewCellListener?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dismissPostButton.setTitle("Dismiss Post", for: .normal)
    }
    
    func setup(with post: Post) {
        authorLabel.text = post.author
        postTitleLabel.text = post.title
        commentsLabel.text = "\(post.numberOfComments) comments"

        dateLabel.text = getElapsedTime(from: post.date)

        postImageViewWidthConstraint.constant = 0
        if let imageURL = post.thumbnailURL {
            loadImage(with: imageURL)
        }
    }
    
    @IBAction private func dismissPostButtonTapped() {
        listener?.dismissPostButtonTapped(at: self)
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

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) {

                DispatchQueue.main.async() {
                    self?.postImageViewWidthConstraint.constant = 70
                    self?.postImageView.image = image
                }
            }
        }.resume()
    }
}
