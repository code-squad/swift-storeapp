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

protocol StoreListViewPresentable: UIViewController {
    
    var viewModel: StoreListViewBindable? { get set }
}

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
        
        setUpLayout()
    }

}

// MARK: - Attrubutes & Layouts

extension StoreListViewController {
    
    private func setUpAttribute() {
        self.view.do {
            $0.addSubview(storeTableView)
        }
    }
    
    private func setUpLayout() {
        storeTableView.frame = self.view.safeAreaLayoutGuide.layoutFrame
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


