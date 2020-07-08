//
//  UserListViewController.swift
//  JET2DemoApp
//
//  Created by Sachin on 05/07/20.
//  Copyright © 2020 Sachin. All rights reserved.
//

import UIKit
import SDWebImage

class UserListViewController: UIViewController {
    @IBOutlet weak var userListTableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    var userDataList = [UsersModel]()
    let viewModel = UsersViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        userListTableView.register(UINib.init(nibName: UserDetailTableViewCell.className, bundle: nil), forCellReuseIdentifier: UserDetailTableViewCell.className)
        attemptFetchUsers()
    }
    private func attemptFetchUsers() {
        viewModel.fetchFromServer()
        viewModel.updateLoadingStatus = { (toShow) in
            DispatchQueue.main.async {
                if toShow {
                    self.activityView.isHidden = false
                    self.activityView.startAnimating()
                }
                else {
                    self.activityView.isHidden = true
                    self.activityView.stopAnimating()
                }
            }
        }
        viewModel.didFinishFetch = { (error) in
            if let err = error {
                print(err.localizedDescription)
            }
            else {
                if let dataArray = self.viewModel.fetchFromStorage() {
                    self.userDataList.removeAll()
                    self.userDataList = dataArray.filter{
                        if let blog = $0.blogId, !blog.isEmpty {
                            return false
                        }
                        return true
                    }
                    self.userListTableView.isHidden = false
                    self.userListTableView.reloadData()
                    if self.userDataList.count == 0 {
                        self.userListTableView.isHidden = true
                        self.noDataLabel.isHidden = false
                    }
                }
            }
        }
    }
}
// MARK: - TableDelegate and Datasource
extension UserListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userDetailTableViewCell = userListTableView.dequeueReusableCell(withIdentifier: UserDetailTableViewCell.className) as! UserDetailTableViewCell
        let url = URL(string: userDataList[indexPath.row].avatar ?? "")
        userDetailTableViewCell.userImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        userDetailTableViewCell.userCityLbl.text = userDataList[indexPath.row].city ?? ""
        userDetailTableViewCell.userNameLbl.text = userDataList[indexPath.row].name ?? ""
        userDetailTableViewCell.userDesignationLbl.text = userDataList[indexPath.row].designation ?? ""
        return userDetailTableViewCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = userDataList.count - 2
        if indexPath.row == lastElement {
            // handle your logic here to get more items, add it to dataSource and reload tableview
            attemptFetchUsers()
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "UserDetailViewController") as! UserDetailViewController
        controller.userData = userDataList[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

