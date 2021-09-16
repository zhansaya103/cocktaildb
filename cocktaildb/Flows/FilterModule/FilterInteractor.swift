//
//  FilterInteractor.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import Foundation
import RxSwift

final class FilterInteractor: FilterInteractorBase, FilterInteractorInput, FilterInteractorOutput {
    
    var input: FilterInteractorInput { return self}
    var output: FilterInteractorOutput { return self }
    var presenter: FilterPresenterBase?

}
