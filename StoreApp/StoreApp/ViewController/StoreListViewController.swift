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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
        
        self.storeTableView.do {
            $0.register(MenuCell.self, forCellReuseIdentifier: MenuCell.reuseId)
            $0.dataSource = self
            $0.rowHeight = UITableView.automaticDimension
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
        
        viewModel.dataDidLoad = { [weak self ] in
            self?.storeTableView.reloadData()
        }
        
        viewModel.dataDidUpadated = { [weak self ] in
            self?.storeTableView.reloadData()
        }
    }
}


// MARK: - UITableViewDataSource

extension StoreListViewController: UITableViewDataSource {
    
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
