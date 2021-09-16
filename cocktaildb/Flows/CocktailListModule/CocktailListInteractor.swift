//
//  CocktailListInteractor.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import Foundation
import RxSwift
import Resolver

final class CocktailListInteractor: CocktailListInteractorBase, CocktailListInteractorInput, CocktailListInteractorOutput {
    
    var intut: CocktailListInteractorInput { return self }
    var output: CocktailListInteractorOutput { return self }
    var presenter: CocktailListPresenterBase?
    
// MARK: - private properties
    
    private var disposeBag = DisposeBag()
    private var networkManager: CocktailNetworkManager
    private var presentableFilter: FilterRepository
    private var loadedCocktailRepositories: PublishSubject<CocktailRepository>
    
// MARK: - init()
    
    init(networkManager: CocktailNetworkManager, presentableFilter: FilterRepository) {
        self.networkManager = networkManager
        self.presentableFilter = presentableFilter
        
        self.loadedCocktailRepositories = PublishSubject<CocktailRepository>()
        cocktailRepositories = loadedCocktailRepositories.asObservable()
        
        let fetchedCategories = networkManager.getCategoryList()
        fetchedCategories
            .subscribe(onNext: {[weak self] value in
                presentableFilter.categories = value
                self?.presentableFilter = presentableFilter
                let firstCategory = value.first!
                
                let fetchedCocktails = networkManager.getCocktails(category: firstCategory.name)
                fetchedCocktails
                    .subscribe(onNext: { [weak self] value in
                        let cocktail = CocktailRepository(category: firstCategory, cocktails: value)
                        self?.loadedCocktailRepositories.onNext(cocktail)
                        self?.cocktailRepositories = (self?.loadedCocktailRepositories.asObservable())!
                    })
                    .disposed(by: (self?.disposeBag)!)
            })
            .disposed(by: disposeBag)
        self.presentableFilter = presentableFilter
        
        cocktailRepositories = loadedCocktailRepositories.asObservable()
    }
    
// MARK: - inputs
    
    func fetchCocktails(category: Category) {
        let fetchedResult = networkManager.getCocktails(category: category.name)
        fetchedResult
            .subscribe(onNext: { [weak self] value in
                let cocktail = CocktailRepository(category: category, cocktails: value)
                self?.loadedCocktailRepositories.onNext(cocktail)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchCategories() {
        let fetchedResult = networkManager.getCategoryList()
        fetchedResult
            .subscribe(onNext: { [weak self ] value in
                self?.presentableFilter.categories = value
            })
            .disposed(by: disposeBag)
    }
    
// MARK: - outputs
    
    var cocktailRepositories: Observable<CocktailRepository>
    
}
