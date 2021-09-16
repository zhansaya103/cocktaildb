//
//  CocktailListRouterInput.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-14.
//

import Foundation
import UIKit

protocol CocktailListRouterInput: AnyObject {
    var view: CocktailListViewControllerInput { get set }
    var interactor: CocktailListInteractorBase { get set }
    var presenter: CocktailListPresenterBase { get set }

    func createModule() -> CocktailListViewControllerInput
    func pushToFilterScreen(navigationConroller: UINavigationController)
}
