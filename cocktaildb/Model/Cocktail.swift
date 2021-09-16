//
//  Cocktail.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-14.
//

import Foundation

struct CocktailRepository {
    let category: Category
    let cocktails: [Cocktail]
}

struct Cocktail: Codable {
    let id: String
    let name: String
    let image: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case image = "strDrinkThumb"
    }
}

struct Category: Codable, Equatable {
    let name: String
    var isSelected: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case name = "strCategory"
    }
}

struct CategoryDto: Codable {
    let categories: [Category]
    private enum CodingKeys: String, CodingKey {
        case categories = "drinks"
    }
}

struct CocktailDto: Codable {
    let drinks: [Cocktail]
    private enum CodingKeys: String, CodingKey {
        case drinks = "drinks"
    }
}
