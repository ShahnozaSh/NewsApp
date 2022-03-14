//
//  PostsViewController.swift
//  NewsApp
//
//  Created by Shahnoza on 10/3/22.
//

import UIKit

class PostsViewController: UIViewController {
    
    var posts = [Posts]()
    var postImages = [PostsImage]()
    let parser = Parser()
    
    var postId = "1"
    
    // MARK: - View Property
    
    var tableview: UITableView = {
        let table = UITableView()
        table.tableFooterView = UIView(frame: .zero)
        table.rowHeight = 180
        table.register(PostViewCell.self forCellRreuseIdentifier: PostsViewCell.identifier)
        
        return table
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    //MARK: - Helpers
    
    private func configureUI() {
        title = "All post"
        view.backgroundColor = .white
        
        configureTableView()
        
    }
    
    private func configureTableView() {
        
        view.addSubview(tableview)
        tableView.frame = view.frame
        tableview.delegate = self
        tableview.dataSource = self
        
        // stretch to tabbar
        
        let adjustForTabbarInsets = UIEdgeInsets(top: 0, left:0, bottom: tabBarController?.tabBar.frame.height ?? 0,
                                                right: 0)
        tableview.contentInset = adjustForTabbarInsets
        tableview.scrollIndicatorInsets = adjustForTabbarInsets
        
    }
    
    func parseJSON() {
        
        parser.getPosts { [weak self] data in
            self?.posts = data
            DispatchQueue.main.async {
                self?.tableview.reloadData()
                
            }
        }
        
        parser.getImagePosts { [weak self] data in
            self?.postImages = data
            DispatchQueue.main.async {
                self?.tableview.reloadData()
            }
        }
    }
}
    // MARK: UITableViewDataSourse

 extension PostsViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfrowsInsection secton: Int) -> Int {
         return posts.count
         
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             guard let cell = tableView.dequeueReusableCell(withIdentifier: PostViewCell.identifier, for: indexPath) as? PostViewCell else { return UITableViewCell() }
             postId = "\(indexPath.row)"
             guard let url = URL(string: postImages.randomElement()?.url ?? "") else { return UITableViewCell() }
             DispatchQueue.global().async {
                 guard let data = try? Data(contentsOf: url) else { return }
                 DispatchQueue.main.async { [weak self] in
                     cell.configure(title: self?.posts[indexPath.row].title ?? "",
                                    subtitle: self?.posts[indexPath.row].description ?? "",
                                    image: data)
                 }
             }
             return cell
         }
     }

//MARK: - UITableViewDelegate

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = CommentTableViewController()
        controller.id = "\(indexPath.row + 1)"
        navigationController?.pushViewController(controller, animated: true)
    }
}
