//
//  ResolverExtension.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        
        register { CocktailNetworkManager() }
        
        register { CocktailListRouter() }
            .implements(CocktailListRouterInput.self)
        register { CocktailListViewController() }
            .implements(CocktailListViewControllerInput.self)
        register { CocktailListPresenter(interactor: resolve(), presentableFilter: resolve()) }
            .implements(CocktailListPresenterOutput.self) 
            .implements(CocktailListPresenterInput.self)
            .implements(CocktailListPresenterBase.self)
        register { CocktailListInteractor(networkManager: resolve(), presentableFilter: resolve()) }
            .implements(CocktailListInteractorInput.self)
            .implements(CocktailListInteractorOutput.self)
            .implements(CocktailListInteractorBase.self)
        
        register { FilterRouter() }
            .implements(FilterRouterInput.self)
        register { FilterPresenter() }
            .implements(FilterPresenterBase.self)
            .implements(FilterPresenterInput.self)
            .implements(FilterPresenterOutput.self)
        register { FilterInteractor() }
            .implements(FilterInteractorBase.self)
            .implements(FilterInteractorInput.self)
            .implements(FilterInteractorOutput.self)
        register { FilterViewController() }
            .implements(FilterViewControllerInput.self)

        register { FilterRepository() }
            .scope(.application)
        register { FilteredCategoryRepository() }
            .scope(.application)
    }
    
}
