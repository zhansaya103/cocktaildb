//
//  CocktailNetworkManager.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-14.
//

import Foundation
import Moya
import RxSwift

struct CocktailNetworkManager {
    private let provider = MoyaProvider<CocktailNetworkService>()
    private let decoder = JSONDecoder()
    
    func getCategoryList() -> Observable<[Category]> {
        return provider.rx
            .request(.getCategoryList)
            .filterSuccessfulStatusAndRedirectCodes()
            .map { response in
                let data = response.data
                var categories: [Category] = []
                do {
                    let categoryDto = try decoder.decode(CategoryDto.self, from: data)
                    categories = categoryDto.categories
                } catch {
                    print(error)
                }
                
                return categories
            }
            .asObservable()
    }
    
    func getCocktails(category: String) -> Observable<[Cocktail]> {
        return provider.rx
            .request(.getCocktailsByCategory(category: category))
            .filterSuccessfulStatusCodes()
            .map { response in
                let data = response.data
                var cocktails: [Cocktail] = []
                do {
                    let cocktailDto = try decoder.decode(CocktailDto.self, from: data)
                    cocktails = cocktailDto.drinks
                } catch {
                    print(error)
                }
                return cocktails
            }
            .asObservable()
    }

}

