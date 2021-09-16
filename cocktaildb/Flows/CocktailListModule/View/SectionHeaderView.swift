//
//  SectionHeaderView.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import UIKit
import SnapKit
import Rswift

class SectionHeaderView: UIView {
    
    var sectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.sectionText()
        label.font =  UIFont(name: "Arial", size: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(sectionLabel)
        self.backgroundColor = R.color.cellBackground()
        
        sectionLabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(10)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
