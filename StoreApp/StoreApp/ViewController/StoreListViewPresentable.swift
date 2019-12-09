//
//  StoreListViewPresentable.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/09.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit


protocol StoreListViewPresentable: UIViewController {
    
    var viewModel: StoreListViewBindable? { get set }
}
