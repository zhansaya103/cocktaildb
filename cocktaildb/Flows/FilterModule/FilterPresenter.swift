//
//  FilterPresenter.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import UIKit
import Resolver
import RxSwift

final class FilterPresenter: FilterPresenterBase, FilterPresenterInput, FilterPresenterOutput {
    
    var input: FilterPresenterInput { return self }
    var output: FilterPresenterOutput { return self }
    
    var view: FilterViewControllerInput?
    weak var interactor: FilterInteractorBase?
    weak var router: FilterRouterInput?
    
    @Injected var filterRepository: FilterRepository
    @Injected var filteredCategoryRepository: FilteredCategoryRepository
    
    private var selectedCategories: [Category] = []
    let publishedSelectedCategories = BehaviorSubject<[Category]>(value: [])
    // MARK: - inputs
    
    func viewReadyToUse() {
        saveFilterState()
    }
    
    func filterButtonTapped() {
        selectedCategories = filterRepository.categories.filter({ $0.isSelected == true })
        filteredCategoryRepository.filter(c: selectedCategories)
        saveFilterState()
        checkFilterState()
    }
    
    func rowDidSelect(_ row: Int) {
        if filterRepository.categories[row].isSelected != nil {
            filterRepository.categories[row].isSelected = !filterRepository.categories[row].isSelected!
        } else {
            filterRepository.categories[row].isSelected = true
        }
        
        checkFilterState()
    }
    
    func rowDidDeselect(_ row: Int) {
        filterRepository.categories[row].isSelected = !filterRepository.categories[row].isSelected!
        checkFilterState()
    }
    
    // MARK: - outputs
    
    var filterStateDidChange = BehaviorSubject<Bool>(value: false)
    
    // MARK: - private methods
    
    private func saveFilterState() {
        selectedCategories = filterRepository.categories.filter({ $0.isSelected == true })
    }
    
    private func checkFilterState() {
        filterStateDidChange.onNext(selectedCategories != filterRepository.categories.filter({ $0.isSelected == true}) )
    }
}
