//
//  PostListViewController.swift
//  iOS-Viper-Architecture
//
//  Created by Amit Shekhar on 18/02/17.
//  Copyright © 2017 Mindorks NextGen Private Limited. All rights reserved.
//

import UIKit
import PKHUD

class PostListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: PostListPresenterProtocol?
    var postList: [PostModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.perform(action: .viewLoad)
        tableView.tableFooterView = UIView()
    }
    
}

extension PostListViewController: PostListViewProtocol {
    func update(with state: PostListState) {
        switch state.posts {
        case nil:
            HUD.hide()
            postList = []
            tableView.reloadData()
        case .loading:
            HUD.show(.progress)
        case let .loaded(.success(posts)):
            HUD.hide()
            postList = posts
            tableView.reloadData()
        case .loaded(.failure):
            HUD.flash(.labeledError(title: "Some error occured", subtitle: "Try again later"))
        }
    }
}

extension PostListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        
        let post = postList[indexPath.row]
        cell.set(forPost: post)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.perform(action: .showDetail(post: postList[indexPath.row]))
    }
    
}
