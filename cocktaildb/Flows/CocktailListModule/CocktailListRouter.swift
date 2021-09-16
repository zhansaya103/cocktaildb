//
//  CocktailListRouter.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import UIKit
import Resolver
import RxSwift

final class CocktailListRouter: CocktailListRouterInput {
    
    @Injected var view: CocktailListViewControllerInput
    @Injected var interactor: CocktailListInteractorBase
    @Injected var presenter: CocktailListPresenterBase
    @Injected var presenterInput: CocktailListPresenterInput
    @Injected var filterRouter: FilterRouterInput
    
    func createModule() -> CocktailListViewControllerInput {
        
        view.presenter = presenter
        presenter.input.router = self
        presenter.input.interactor = interactor
        presenter.input.view = view
        interactor.intut.presenter = presenter

        return view
    }
    
    func pushToFilterScreen(navigationConroller: UINavigationController) {
        
        let filterModule = filterRouter.createModule() as! UIViewController
        navigationConroller.pushViewController(filterModule, animated: true)
        
    }
    
}
