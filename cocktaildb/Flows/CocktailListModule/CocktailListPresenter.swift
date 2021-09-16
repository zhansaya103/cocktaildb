//
//  CocktailListPresenter.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import UIKit
import RxSwift
import Resolver

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
                self?.filteredCategories = value
                interactor.intut.fetchCocktails(category: value.first!)
                print("test: \(value)")
            })
            .disposed(by: disposeBag)
        
    }
    
    // MARK: - inputs
    lazy var view: CocktailListViewControllerInput? = nil
    var interactor: CocktailListInteractorBase?
    var router: CocktailListRouterInput?
    var presentableFilter: FilterRepository?
    
    func viewReadyToUse() {
        view?.showLoadingIndicator(title: "Loading", description: "")
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
    
    func showFilterViewController(navigationController: UINavigationController) {
        
    }
    
    // MARK: - outputs
    
    let cocktailRepositories = BehaviorSubject<[CocktailRepository]>(value: [])
    
}
