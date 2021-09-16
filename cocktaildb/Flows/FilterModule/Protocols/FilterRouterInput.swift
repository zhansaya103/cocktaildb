//
//  FilterRouterInput.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import UIKit
import RxSwift

protocol FilterRouterInput: class {
    var interactor: FilterInteractorBase { get set }
    var presenter: FilterPresenterBase { get set }
    var view: FilterViewControllerInput { get set }
    
    func createModule()-> FilterViewControllerInput
}
