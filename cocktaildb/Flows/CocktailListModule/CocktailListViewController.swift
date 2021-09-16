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

class CocktailListViewController: UIViewController, CocktailListViewControllerInput {
    
    var presenter: CocktailListPresenterBase?
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
        setRightBarButtonItem()
        
        presenter?.input.viewReadyToUse()
    }
    
    
    // MARK: - inputs
    func showLoadingIndicator(title: String, description: String) {
        showIndicator(withTitle: title, and: description)
    }
    
    func hideLoadingIndicator() {
        hideIndicator()
    }
    
    func updateFilterButton() {
        
    }
}

// MARK: - private methods

extension CocktailListViewController {
    private func setRightBarButtonItem() {
        if #available(iOS 13.0, *) {
            let filterButton = UIBarButtonItem(image: UIImage(named: "filter-clear"), style: .plain, target: self, action: #selector(showFilter))
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

extension CocktailListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return try! presenter!.output.cocktailRepositories.value().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return try! presenter!.output.cocktailRepositories.value()[section].cocktails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CocktailListCell.identifier, for: indexPath)
        if let cocktailCell = cell as? CocktailListCell {
            let cocktail = try! presenter!.output.cocktailRepositories.value()[indexPath.section].cocktails[indexPath.row]
            cocktailCell.nameLabel.text = cocktail.name
            let url = URL(string: cocktail.image)
            let placeHolter = UIImage(named: "cocktail-gradient")
            cocktailCell.cardView.sd_setImage(with: url, placeholderImage:placeHolter)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cocktails = try! presenter!.output.cocktailRepositories.value()[indexPath.section].cocktails
        if cocktails.count > 0 && indexPath.row + 1 == cocktails.count {
                print("reached the bottom")
            presenter!.input.scrollDidReachNextSection(indexPath.section + 1)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return try! presenter!.output.cocktailRepositories.value()[section].category.name
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = SectionHeaderView(frame: .zero)
        headerView.sectionLabel.text = try! presenter!.output.cocktailRepositories.value()[section].category.name
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
}
