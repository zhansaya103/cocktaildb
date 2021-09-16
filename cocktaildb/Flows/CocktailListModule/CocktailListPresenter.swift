//
//  CocktailListPresenter.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import UIKit
import RxSwift
import Resolver
import Rswift

final class CocktailListPresenter: CocktailListPresenterBase, CocktailListPresenterOutput, CocktailListPresenterInput {
    var input: CocktailListPresenterInput { return self }
    var output: CocktailListPresenterOutput { return self }
    
// MARK: - private properties
    
    private let disposeBag = DisposeBag()
    private var cocktailRepositoriesPrivate: [CocktailRepository] = []
    private var filteredCategories: [Category] = []
    @Injected var filteredCategoryRepository: FilteredCategoryRepository
    
// MARK: - init()
    
    init(interactor: CocktailListInteractorBase, presentableFilter: FilterRepository) {
        
        self.interactor = interactor
        self.presentableFilter = presentableFilter
        self.filteredCategories = presentableFilter.categories
        
        interactor.output.cocktailRepositories
            .subscribe(onNext: { [weak self] value in
                if !(self?.cocktailRepositoriesPrivate.contains(where: { $0.category.name == value.category.name }))! {
                    self?.cocktailRepositoriesPrivate.append(value)
                    self?.cocktailRepositories.onNext(self?.cocktailRepositoriesPrivate ?? [])
                }
                
            })
            .disposed(by: disposeBag)
        
        filteredCategoryRepository.filteredCategories
            .subscribe(onNext: { [weak self] value in
                self?.cocktailRepositoriesPrivate.removeAll()
                self?.filteredCategories = value.isEmpty ? presentableFilter.categories : value
                interactor.intut.fetchCocktails(category: value.isEmpty ? presentableFilter.categories.first! : value.first!)
                
                self?.view?.updateFilterButton(image: value.isEmpty ? R.image.filterClear()! : R.image.filterSelected()!)
                
            })
            .disposed(by: disposeBag)
    
    }
    
// MARK: - inputs
    
    lazy var view: CocktailListViewControllerInput? = nil
    var interactor: CocktailListInteractorBase?
    weak var router: CocktailListRouterInput?
    var presentableFilter: FilterRepository?
    
    func viewReadyToUse() {
        view?.showLoadingIndicator(title: NSLocalizedString("flows.cocktail_list_module.cocktail_list_presenter.showLoadingIndicator.title", comment: ""), description: "")
    }
    
    func hideLoaderTrigger() {
        view?.hideLoadingIndicator()
    }
    
    func scrollDidReachNextSection(_ nextSectionIndex: Int) {
        guard let presentableFilter = presentableFilter,
              !presentableFilter.categories.isEmpty,
              nextSectionIndex < filteredCategories.count else { return }
        interactor?.intut.fetchCocktails(category: filteredCategories[nextSectionIndex])
    }
    
    func pushFilterViewControllerTrigger(navigationController: UINavigationController) {
        router?.pushToFilterScreen(navigationConroller: navigationController)
    }
    
    func updateFilterButtonImageTrigger() {
        
    }
    
// MARK: - outputs
    
    let cocktailRepositories = BehaviorSubject<[CocktailRepository]>(value: [])
    
}
