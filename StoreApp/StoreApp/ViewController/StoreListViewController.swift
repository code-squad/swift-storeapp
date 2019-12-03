//
//  ViewController.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/04.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit
import Then

class StoreListViewController: UIViewController {
    
    // MARK: - UI
    
    private let storeTableView = UITableView(frame: .zero)
    
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

