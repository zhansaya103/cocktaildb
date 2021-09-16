//
//  FilterRouter.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import UIKit
import Resolver
import RxSwift

final class FilterRouter: FilterRouterInput {
    
    @Injected var interactor: FilterInteractorBase
    @Injected var presenter: FilterPresenterBase
    @Injected var view: FilterViewControllerInput
    
    func createModule() -> FilterViewControllerInput {
        view.presenter = presenter
        interactor.input.presenter = presenter
        presenter.input.router = self
        presenter.input.interactor = interactor
        return view
    }
    
}
