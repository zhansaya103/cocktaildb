//
//  FilterRouterInput.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import UIKit
import RxSwift

protocol FilterRouterInput: AnyObject {
    var interactor: FilterInteractorBase { get set }
    var presenter: FilterPresenterBase { get set }
    var view: FilterViewControllerInput { get set }
    
    func createModule()-> FilterViewControllerInput
    func pushToMovieScreen(navigationConroller:UINavigationController)
}

protocol FilterViewControllerInput: AnyObject {
    var presenter: FilterPresenterBase? { get set }
}

protocol FilterPresenterBase {
    var input: FilterPresenterInput { get }
    var output: FilterPresenterOutput { get }
}
protocol FilterPresenterInput: AnyObject {
    var view: FilterViewControllerInput? { get set }
    var interactor: FilterInteractorBase? { get set }
    var router: FilterRouterInput? { get set }
    
    func viewReadyToUse()
    func viewWillDisappear()
    func filterButtonTapped()
    func rowDidSelect(_ row: Int)
    func rowDidDeselect(_ row: Int)
    
}
protocol FilterPresenterOutput: AnyObject {
    var filterRepository: FilterRepository { get set } // BehaviorSubject<[FilterRepository]> { get }
    var filterStateDidChange: BehaviorSubject<Bool> { get set }
}

protocol FilterInteractorBase {
    var input: FilterInteractorInput { get }
    var output: FilterInteractorOutput { get }
}
protocol FilterInteractorInput: AnyObject {
    var presenter: FilterPresenterBase? { get set }
}
protocol FilterInteractorOutput: AnyObject {
    
}
