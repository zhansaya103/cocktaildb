//
//  CocktailListInteractorInput.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import Foundation

import Foundation
import RxSwift

protocol CocktailListInteractorBase {
    var intut: CocktailListInteractorInput { get }
    var output: CocktailListInteractorOutput { get }
}

protocol CocktailListInteractorInput: AnyObject {
    var presenter: CocktailListPresenterBase? { get set }
    func fetchCocktails(category: Category)
    func fetchCategories()
}

protocol CocktailListInteractorOutput: AnyObject {
    var cocktailRepositories: Observable<CocktailRepository> { get }
    var selectedCategories: Observable<[Category]> { get }
    
}
