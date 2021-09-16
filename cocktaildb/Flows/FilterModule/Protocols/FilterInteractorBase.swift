//
//  FilterInteractorBase.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import Foundation

protocol FilterInteractorBase: class {
    var input: FilterInteractorInput { get }
    var output: FilterInteractorOutput { get }
}
protocol FilterInteractorInput: AnyObject {
    var presenter: FilterPresenterBase? { get set }
}
protocol FilterInteractorOutput: AnyObject {
    
}
