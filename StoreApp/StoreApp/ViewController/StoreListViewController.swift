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
import Toaster


final class StoreListViewController: UIViewController, StoreListViewPresentable {
    
    // MARK: - UI
    
    private let storeTableView = UITableView()
    
    // MARK: - Dependencies
    
    var viewModel: StoreListViewBindable? {
        didSet { bindViewModel() }
    }
    
    // MARK: - Properties
    
    let storeTableViewManager = StoreTableViewManager()
    
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
            $0.dataSource = storeTableViewManager
            $0.delegate = storeTableViewManager
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
        
        storeTableViewManager.stores = viewModel
        
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
                $0.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self?.present($0, animated: true, completion: nil)
            }
        }
        
        viewModel.dataDidSelected = { menu in
            let description = "\(menu.title)\n\(menu.salePrice)"

            DispatchQueue.main.async {
                Toast(text: description, duration: Delay.short).show()
            }
        }
    }
}
