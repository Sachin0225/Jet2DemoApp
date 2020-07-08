//
//  ArticlesViewController.swift
//  JET2DemoApp
//
//  Created by Sachin on 05/07/20.
//  Copyright © 2020 Sachin. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {
    @IBOutlet weak var articlesListTableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    let viewModel = ArticlesViewModel()
    var articlesDataList = [ArticlesModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        articlesListTableView.register(UINib.init(nibName: ArticlesTableViewCell.className, bundle: nil), forCellReuseIdentifier: ArticlesTableViewCell.className)
        attemptFetchArticles()
    }
    
    private func attemptFetchArticles() {
        viewModel.fetchArticles()
        viewModel.updateLoadingStatus = { (toShow) in
            DispatchQueue.main.async {
                if toShow {
                    self.activityView.isHidden = false
                    self.activityView.startAnimating()
                }
                else {
                    self.activityView.stopAnimating()
                    self.activityView.isHidden = true
                }
            }
        }
        viewModel.didFinishFetch = { (error) in
            if let err = error {
                print(err.localizedDescription)
            }
            else {
                if let data = self.viewModel.fetchFromStorage() {
                    self.articlesDataList.removeAll()
                    self.articlesDataList =  data
                    self.articlesListTableView.isHidden = false
                    self.articlesListTableView.reloadData()
                    if self.articlesDataList.count == 0 {
                        self.articlesListTableView.isHidden = true
                        self.noDataLabel.isHidden = false
                    }
                }
            }
        }
    }
}

// MARK: - TableDelegate and Datasource
extension ArticlesViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleCell = articlesListTableView.dequeueReusableCell(withIdentifier: ArticlesTableViewCell.className) as! ArticlesTableViewCell
        articleCell.cellDescriptor(articleData: articlesDataList[indexPath.row])
        return articleCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           let lastElement = articlesDataList.count - 2
           if indexPath.row == lastElement {
               // handle your logic here to get more items, add it to dataSource and reload tableview
               attemptFetchArticles()
            }
       }
}

