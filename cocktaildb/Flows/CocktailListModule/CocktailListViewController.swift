//
//  ViewController.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-14.
//

import UIKit
import RxSwift
import MBProgressHUD
import SDWebImage
import Rswift

class CocktailListViewController: UIViewController, CocktailListViewControllerInput {
    
    weak var presenter: CocktailListPresenterBase?
    private let disposeBag = DisposeBag()
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: .zero)
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        
        tableView.register(CocktailListCell.self, forCellReuseIdentifier: CocktailListCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter?.output.cocktailRepositories
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
                self?.presenter?.input.hideLoaderTrigger()
            })
            .disposed(by: disposeBag)
        
        setUpConstraints()
        setRightBarButtonItem(image: R.image.filterClear()!)
        
        presenter?.input.viewReadyToUse()
        
    }
    
// MARK: - inputs
    func showLoadingIndicator(title: String, description: String) {
        showIndicator(withTitle: title, and: description)
    }
    
    func hideLoadingIndicator() {
        hideIndicator()
    }
    
    func updateFilterButton(image: UIImage) {
        setRightBarButtonItem(image: image)
    }
}

// MARK: - private methods

extension CocktailListViewController {
    private func setRightBarButtonItem(image: UIImage) {
        if #available(iOS 12.0, *) {
            let filterButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showFilter))
            navigationItem.rightBarButtonItem = filterButton
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc private func showFilter() {
        presenter?.input.pushFilterViewControllerTrigger(navigationController: navigationController!)
    }
    
    private func setUpConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 60
        tableView.snp.makeConstraints({ (make) -> Void  in
            make.bottom.equalTo(self.view)
            make.top.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
        })
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CocktailListViewController: UITableViewDelegate, UITableViewDataSource {
    
// MARK: - UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = SectionHeaderView(frame: .zero)
        headerView.sectionLabel.text = try! presenter!.output.cocktailRepositories.value()[section].category.name
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cocktails = try! presenter!.output.cocktailRepositories.value()[indexPath.section].cocktails
        if cocktails.count > 0 && indexPath.row + 1 == cocktails.count {
            presenter!.input.scrollDidReachNextSection(indexPath.section + 1)
        }
        
    }
    
// MARK: - UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return try! presenter!.output.cocktailRepositories.value().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return try! presenter!.output.cocktailRepositories.value()[section].cocktails.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return try! presenter!.output.cocktailRepositories.value()[section].category.name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CocktailListCell.identifier, for: indexPath) as? CocktailListCell {
            let cocktail = try! presenter!.output.cocktailRepositories.value()[indexPath.section].cocktails[indexPath.row]
            cell.nameLabel.text = cocktail.name
            let url = URL(string: cocktail.image)
            let placeHolter = R.image.cocktailGradient()
            cell.cardView.sd_setImage(with: url, placeholderImage:placeHolter)
            return cell
        }
        
        return UITableViewCell()
        
    }
    
}
