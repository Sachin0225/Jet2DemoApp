//
//  ServiceRouter.swift
//  JET2DemoApp
//
//  Created by Sachin on 05/07/20.
//  Copyright © 2020 Sachin. All rights reserved.
//

import UIKit
import Alamofire

final class ServiceRouter {
    // MARK: - Singleton
    static let shared = ServiceRouter()
    
    //Initializer access level
    private init(){}
    // MARK: - Services
    func requestFetchUsers(with pageNumber: Int ,And viewModel : UsersViewModel, completion: @escaping (Error?) -> ()) {
        let url = "\(AppConstant.ServiceURLs.HOST)\(AppConstant.ServiceURLs.GET_USERS.replacingOccurrences(of: "s123456", with: "\(pageNumber)"))"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success( _):
                    if let jsonData = response.data, jsonData.count > 10 {
                        if let error = viewModel.parse(jsonData) {
                            completion(error)
                        }
                        else {
                            completion(nil)
                        }
                    }
                    else {
                        let err = NSError(domain: "com.", code: 400, userInfo: [ "NSLocalizedDescription" : "Limit Reached"])
                        completion(err)
                    }
                case .failure(let error):
                    print(error)
                    completion(error)
                }
        }
    }
    
    func requestFetchArticles(with pageNumber: Int ,And viewModel : ArticlesViewModel, completion: @escaping (Error?) -> ()) {
        let url = "\(AppConstant.ServiceURLs.HOST)\(AppConstant.ServiceURLs.GET_ARTICLES.replacingOccurrences(of: "s123456", with: "\(pageNumber)"))"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success( _):
                    if let jsonData = response.data {
                        if let error = viewModel.parse(jsonData) {
                            completion(error)
                        }
                        else {
                            completion(nil)
                        }
                    }
                case .failure(let error):
                    print(error)
                    completion(error)
                }
        }
    }
}
