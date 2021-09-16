//
//  CocktailNetworkService.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-14.
//

import Foundation
import Moya

enum CocktailNetworkService {
    case getCategoryList
    case getCocktailsByCategory(category: String)
}

extension CocktailNetworkService: TargetType {
    var baseURL: URL {
        URL(string: "https://www.thecocktaildb.com/api/json/v1/1")!
    }
    
    var path: String {
        switch self {
        case .getCategoryList:
            return "/list.php"
        case .getCocktailsByCategory(_):
            return "/filter.php"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getCategoryList:
            return .requestParameters(parameters: ["c": "list"], encoding: URLEncoding.queryString)
        case let .getCocktailsByCategory(category):
            return .requestParameters(parameters: ["c": category], encoding: URLEncoding.queryString)
            
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

