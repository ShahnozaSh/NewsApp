//
//  UsersViewController.swift
//  NewsApp
//
//  Created by Shahnoza on 10/3/22.
//

import UIKit


private let userIdentifier = "userCell"
    
class UsersViewController: UIViewController {
    
    var users = [Users]()
    var parser = Parser()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
        parseJSON()
        
    }
    
    private func configureUI() {
        title = "All user"
        
        tableView.register(UITableViewCell.self, forCellWithReuseIdentifier: userIdentifier)
        
    }
    
//MARK:  Helpers
    
    func parseJSON() {
        parser.getUsers { [weak self] data in
            self?.users = data
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                
            }
        }
    }
    
    func showError(_ error: Error?) {
        if let error = error {
            print ("Debug: \(String(describing: error.localizedDescription))")
            return
            
        }
    }
  
//MARK: DataSourse
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UserInfoViewController()
        let user = users[indexPath.row]
        vc.userId.text = "id = \(user.id)"
        vc.userName.text = "name = \(user.name)"
        vc.userPhone.text = "phone = \(user.phone)"
        vc.nickName.text = "userName = \(user.username)"
        vc.userWebSite.text = "webSite = \(user.webSite)"
        vc.userCompany.text = "company = \(user.company.name)"
        vc.userEmail.text = "email = \(user.email)"
        navigationController?.pushViewController(vc, animated:true)
    }
}
