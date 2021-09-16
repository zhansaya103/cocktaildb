//
//  FilterViewController.swift
//  cocktaildb
//
//  Created by Zhansaya Ayazbayeva on 2021-09-15.
//

import UIKit
import RxSwift

class FilterViewController: UIViewController, FilterViewControllerInput {
    var presenter: FilterPresenterBase?
    
    private var tableView: UITableView!
    private var filterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView = UITableView()
        tableView.allowsMultipleSelection = true
        view.addSubview(tableView)
        
        filterButton = FilterButton(frame: .zero)
        view.addSubview(filterButton)
        filterButton.isHidden = true
        setUpConstraints()
        
        filterButton.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter?.output.filterStateDidChange
            .subscribe(onNext: { [weak self] value in
                print(value)
                self?.filterButton.isHidden = !value
                self?.tableView.reloadData()
            })
        presenter?.input.viewReadyToUse()
        tableView.reloadData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.input.viewWillDisappear()
        super.viewWillDisappear(true)
    }
    // MARK: - private methods
    
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
            make.height.equalTo(tableView.rowHeight * 14)
        }
        
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.snp.makeConstraints { make in
            make.bottom.equalTo(tableView).offset(80)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filter = presenter?.output.filterRepository {
            return filter.categories.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.identifier, for: indexPath)
        if let filterCell = cell as? FilterCell {
            if let filter = presenter?.output.filterRepository {
                filterCell.nameLabel.text = filter.categories[indexPath.row].name
                if let isSelected = filter.categories[indexPath.row].isSelected {
                    filterCell.accessoryType = isSelected ? .checkmark : .none
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return  }
        cell.backgroundColor = .white
        
        presenter?.input.rowDidSelect(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        presenter?.input.rowDidDeselect(indexPath.row)
        
    }
    
}

