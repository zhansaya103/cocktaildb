//
//  CocktailListViewControllerInput.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import Foundation

protocol CocktailListViewControllerInput {
    var presenter: CocktailListPresenterBase? { get set }
    
    func showLoadingIndicator(title: String, description: String)
    func hideLoadingIndicator()
    func updateFilterButton()
}
