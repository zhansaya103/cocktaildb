//
//  FilterButton.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import UIKit
import SnapKit

class FilterButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        self.tintColor = .white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.setTitle(NSLocalizedString("flow.cocktail_list_module.view.filter_button.title", comment: "") , for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
