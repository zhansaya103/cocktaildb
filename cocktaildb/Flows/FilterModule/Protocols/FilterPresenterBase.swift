//
//  FilterPresenterBase.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import Foundation
import RxSwift

protocol FilterPresenterBase: class {
    var input: FilterPresenterInput { get }
    var output: FilterPresenterOutput { get }
}

protocol FilterPresenterInput: AnyObject {
    var view: FilterViewControllerInput? { get set }
    var interactor: FilterInteractorBase? { get set }
    var router: FilterRouterInput? { get set }
    
    func viewReadyToUse()
    func filterButtonTapped()
    func rowDidSelect(_ row: Int)
    func rowDidDeselect(_ row: Int)
    
}

protocol FilterPresenterOutput: AnyObject {
    var filterRepository: FilterRepository { get set }
    var filterStateDidChange: BehaviorSubject<Bool> { get set }
}
