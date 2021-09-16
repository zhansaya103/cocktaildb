//
//  CocktailListPresenterBase.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import UIKit
import RxSwift

protocol CocktailListPresenterBase: class {
    var input: CocktailListPresenterInput { get }
    var output: CocktailListPresenterOutput { get }
}

protocol CocktailListPresenterInput: AnyObject {
    var view: CocktailListViewControllerInput? { get set }
    var interactor: CocktailListInteractorBase? { get set }
    var router: CocktailListRouterInput? { get set }
    var presentableFilter: FilterRepository? { get set }
    
    func viewReadyToUse()
    func hideLoaderTrigger()
    func scrollDidReachNextSection(_ nextSectionIndex: Int)
    func pushFilterViewControllerTrigger(navigationController: UINavigationController)
    func updateFilterButtonImageTrigger()
}

protocol CocktailListPresenterOutput: AnyObject {
    var cocktailRepositories: BehaviorSubject<[CocktailRepository]> { get }
}
