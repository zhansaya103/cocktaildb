//
//  FilterButton.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import UIKit
import SnapKit
import Rswift

class FilterButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = R.color.filterButtonBackground()
        self.tintColor = R.color.filterButtonText()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.setTitle(R.string.localizable.flowCocktail_list_moduleViewFilter_buttonTitle(preferredLanguages: []) , for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
