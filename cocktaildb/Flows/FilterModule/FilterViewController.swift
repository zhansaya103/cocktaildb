//
//  FilterViewController.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import UIKit
import RxSwift
import Rswift

class FilterViewController: UIViewController, FilterViewControllerInput {
    weak var presenter: FilterPresenterBase?
    
    private var tableView: UITableView!
    private var filterButton: UIButton!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = R.color.cellBackground()
        
        tableView = UITableView()
        tableView.allowsMultipleSelection = true
        view.addSubview(tableView)
        
        filterButton = FilterButton(frame: .zero)
        view.addSubview(filterButton)
        enableFilterButton(false)
        setUpConstraints()
        
        filterButton.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter?.output.filterStateDidChange
            .subscribe(onNext: { [weak self] value in
                print(value)
                self?.enableFilterButton(value)
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        presenter?.input.viewReadyToUse()
        tableView.reloadData()
    }
    
    // MARK: - private methods
    
    private func enableFilterButton(_ value: Bool) {
        filterButton.isEnabled = value
        UIView.animate(withDuration: 0.5) {
            self.filterButton.layer.opacity = value == true ? 1.0 : 0.5
        }
        
    }
    
    @objc private func applyFilter() {
        presenter?.input.filterButtonTapped()
        navigationController?.popViewController(animated: true)
    }
    
    private func setUpConstraints() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 45
        tableView.snp.makeConstraints { make -> Void  in
            make.top.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.bottom.equalTo(filterButton.snp.top).offset(-20)
        }
        
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
// MARK: - UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return  }
        cell.backgroundColor = R.color.cellBackground()
        
        presenter?.input.rowDidSelect(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        presenter?.input.rowDidDeselect(indexPath.row)
        
    }

// MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filter = presenter?.output.filterRepository {
            return filter.categories.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.identifier, for: indexPath) as? FilterCell {
            if let filter = presenter?.output.filterRepository {
                cell.nameLabel.text = filter.categories[indexPath.row].name
                cell.accessoryType = filter.categories[indexPath.row].isSelected == true
                    ? .checkmark
                    : .none
                
            }
            return cell
        }
        
        return UITableViewCell()
        
    }
    
}

