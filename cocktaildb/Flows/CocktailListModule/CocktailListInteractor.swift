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
    
    
    var selectedCategories: Observable<[Category]>
  
    var intut: CocktailListInteractorInput { return self }
    var output: CocktailListInteractorOutput { return self }
    
    var presenter: CocktailListPresenterBase?
    
    // MARK: - private properties
    private var disposeBag = DisposeBag()
    private var networkManager: CocktailNetworkManager
    private var presentableFilter: FilterRepository
    private var loadedCocktailRepositories: PublishSubject<CocktailRepository>
    
    var cocktailRepositories: Observable<CocktailRepository>
    
    init(networkManager: CocktailNetworkManager, presentableFilter: FilterRepository) {
        self.networkManager = networkManager
        self.presentableFilter = presentableFilter
        
        //let _disposeBag = DisposeBag()
        let _loadedCocktailRepositories = PublishSubject<CocktailRepository>()
        self.loadedCocktailRepositories = _loadedCocktailRepositories
        cocktailRepositories = loadedCocktailRepositories.asObservable()
        
        let loadedCategories = BehaviorSubject<[Category]>(value: presentableFilter.categories)
        selectedCategories = loadedCategories.asObservable()
        
        let fetchedCategories = networkManager.getCategoryList()
        fetchedCategories
            .subscribe(onNext: { value in
                //print(value)
                presentableFilter.categories = value
                self.presentableFilter = presentableFilter
                let firstCategory = value.first!
                
                let fetchedCocktails = networkManager.getCocktails(category: firstCategory.name)
                fetchedCocktails
                    .subscribe(onNext: { [weak self] value in
                        let cocktail = CocktailRepository(category: firstCategory, cocktails: value)
                        _loadedCocktailRepositories.onNext(cocktail)
                        self?.loadedCocktailRepositories = _loadedCocktailRepositories
                        self?.cocktailRepositories = (self?.loadedCocktailRepositories.asObservable())!
                    })
                
            })
            .disposed(by: disposeBag)
        self.presentableFilter = presentableFilter
        
        self.loadedCocktailRepositories = _loadedCocktailRepositories
        cocktailRepositories = loadedCocktailRepositories.asObservable()
    }
    // MARK: - inputs
    
    func fetchCocktails(category: Category) {
        let fetchedResult = networkManager.getCocktails(category: category.name)
        fetchedResult
            .subscribe(onNext: { [weak self] value in
                print(value)
                let cocktail = CocktailRepository(category: category, cocktails: value)
                self?.loadedCocktailRepositories.onNext(cocktail)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchCategories() {
        let fetchedResult = networkManager.getCategoryList()
        fetchedResult
            .subscribe(onNext: { [weak self ] value in
                print(value)
                self?.presentableFilter.categories = value
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - outputs
    
    
}
