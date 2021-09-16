//
//  FilterViewControllerInput.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import Foundation

protocol FilterViewControllerInput: class {
    var presenter: FilterPresenterBase? { get set }
}
