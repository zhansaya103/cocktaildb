//
//  CocktailListCell.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import UIKit
import SnapKit

class CocktailListCell: UITableViewCell {
    
    static let identifier = "CocktailListCell"
    
    var cardView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.cellText()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cardView)
        contentView.addSubview(nameLabel)
        
        cardView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.leading.equalTo(contentView).offset(10)
            make.centerY.equalTo(contentView)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(70)
            make.height.equalTo(cardView)
            make.centerY.equalTo(cardView)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cardView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.autoreverse],
                       animations: {
                        tappedImage.layer.opacity = 0.8
                       },
                       completion: { _ in
                        tappedImage.layer.opacity = 1
                       }
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
