//
//  AppConstant.swift
//  JET2DemoApp
//
//  Created by Sachin on 05/07/20.
//  Copyright © 2020 Sachin. All rights reserved.
//

import UIKit
struct Config{
       static let KPageLimit = 10
}
class AppConstant {
    struct ServiceURLs {
        /******APP HOST************/
        static let HOST = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1"

    /******APP URLS************/
        static let GET_ARTICLES = "/blogs?page=s123456&limit=\(Config.KPageLimit)"
        static let GET_USERS = "/users?page=s123456&limit=\(Config.KPageLimit)"
    }
}


