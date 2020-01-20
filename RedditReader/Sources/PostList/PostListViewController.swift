//
//  PostListViewController.swift
//  RedditReader
//
//  Created by Ignacio Diaz on 20/01/2020.
//  Copyright © 2020 Ignacio Diaz. All rights reserved.
//

import UIKit

protocol PostListViewControllerListener: class {
    func fetchData(_ completion: @escaping (() -> Void))
    func getNumberOfPosts() -> Int
    func getPost(by index: Int) -> Post?
}

final class PostListViewController: UITableViewController {

    private var detailViewController: PostDetailViewController? = nil
    private lazy var viewModel = PostListViewModel()
    
    private let cellIdentifier = "PostCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reddit Posts"
        
        viewModel.fetchData { [weak self] in
            self?.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
            let controller = (segue.destination as? UINavigationController)?.topViewController as? PostDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow,
            let post = viewModel.getPost(by: indexPath.row) {
                controller.post = post
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
        }
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfPosts()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostListTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    // MARK: - PostListViewControllable

    func reloadData() {
        tableView.reloadData()
    }
}
