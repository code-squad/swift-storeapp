//
//  ViewController.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/04.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit
import SnapKit
import Then


final class StoreListViewController: UIViewController, StoreListViewPresentable {
    
    // MARK: - UI
    
    private let storeTableView = UITableView()
    
    // MARK: Properties
    
    var viewModel: StoreListViewBindable? {
        didSet { bindViewModel() }
    }
    
    // MARK: - Life Cycle
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setUpAttribute()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpConstraints()
    }
    
}

// MARK: - Attrubutes & Layouts

extension StoreListViewController {
    
    private func setUpAttribute() {
        self.view.do {
            $0.addSubview(storeTableView)
        }
        
        storeTableView.do {
            $0.register(MenuCell.self,
                        forCellReuseIdentifier: MenuCell.reuseId)
            $0.register(CategoryHeaderView.self,
                        forHeaderFooterViewReuseIdentifier: CategoryHeaderView.reuseId)
            $0.dataSource = self
            $0.delegate = self
            $0.rowHeight = UITableView.automaticDimension
            $0.sectionHeaderHeight = 70
            $0.separatorStyle = .none
        }
    }
    
    private func setUpConstraints() {
        storeTableView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Bind

extension StoreListViewController {
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.dataDidLoad = { [weak self] in
            self?.storeTableView.reloadData()
        }
        
        viewModel.dataDidUpadated = { [weak self] in
            self?.storeTableView.reloadData()
        }
        
        viewModel.errorDidOccured = { [weak self] error in
            let alert = UIAlertController(title: "네트워크 오류",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            alert.do {
                $0.addAction(.init(title: "OK", style: .cancel, handler: nil))
                self?.present($0, animated: true, completion: nil)
            }
        }
    }
}


// MARK: - UITableViewDataSource

extension StoreListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numOfCategories() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numOfMenusInCategory(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(with: MenuCell.self, for: indexPath),
            let menu = viewModel?[menu: indexPath]
            else { return .init() }
        
        cell.configure(menu)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension StoreListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let categoryHeader = tableView.dequeueReusableHeaderFooterView(with: CategoryHeaderView.self),
            let category = viewModel?[category: section]
            else { return nil }
        
        categoryHeader.configure(category: category)
        return categoryHeader
    }
}
