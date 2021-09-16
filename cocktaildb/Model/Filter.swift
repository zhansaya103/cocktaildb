//
//  Filter.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-14.
//

import Foundation
import RxSwift

final class FilterRepository {
    var categories: [Category] = []
    
}

final class FilteredCategoryRepository {
    var filteredCategories = PublishSubject<[Category]>()
    func filter(categoryList: [Category]) {
        filteredCategories.onNext(categoryList)
    }
}
