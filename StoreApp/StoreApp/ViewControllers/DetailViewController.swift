//
//  DetailViewController.swift
//  StoreApp
//
//  Created by yuaming on 17/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  @IBOutlet weak var thumbnailScrollView: UIScrollView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var pointLabel: UILabel!
  @IBOutlet weak var deliveryInfoLabel: UILabel!
  @IBOutlet weak var deliveryFeeLabel: UILabel!
  @IBOutlet weak var detailInfoContainer: UIView!
  @IBOutlet weak var sectionScrollView: UIScrollView!
  
  
  var itemDetail: StoreDetailItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  fileprivate func setup() {
    NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: .detailData, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(updateThumbnail(_:)), name: .thumbnail, object: nil)
    
    self.navigationController?.isNavigationBarHidden = true
    self.itemDetail?.requestData()
  }
  
  @objc fileprivate func updateData(_ notification: Notification) {
    guard let userInfo = notification.userInfo,
      let detailTitle = userInfo[Constants.detailTitle] as? String,
      let itemDetailData = userInfo[Constants.detailData] as? ItemDetailData else { return }
    
    configueThumbnailScrollViewSize(itemDetailData.thumbnailImageUrls.count)
    updateDetailInfoContainer(detailTitle, itemDetailData)
  }
  
  @objc fileprivate func updateThumbnail(_ notification: Notification) {
    guard let userInfo = notification.userInfo,
      let index = userInfo[Constants.imageIndex] as? Int,
      let image = userInfo[Constants.image] as? UIImage else { return }
    
    DispatchQueue.main.async {
      self.updateThumbnailScrollView(index: index, image: image)
    }
  }
  
  @IBAction func orderButtonDidTapped(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}

fileprivate extension DetailViewController {
  func configueThumbnailScrollViewSize(_ count: Int) {
    thumbnailScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(count),
                                             height: thumbnailScrollView.frame.height)
  }
  
  func updateDetailInfoContainer(_ detailTitle: String, _ data: ItemDetailData) {
    titleLabel.text = detailTitle
    descriptionLabel.text = data.productDescription
    priceLabel.text = data.prices.last
    pointLabel.text = data.point
    deliveryFeeLabel.text = data.deliveryFee
    deliveryInfoLabel.text = data.deliveryInfo
  }
  
  func updateThumbnailScrollView(index: Int, image: UIImage) {
    let xCoordinate: CGFloat = thumbnailScrollView.frame.width * CGFloat(index)
    let thumbnail = UIImageView(frame: CGRect(x: xCoordinate, y: 0, width: UIScreen.main.bounds.width, height: thumbnailScrollView.frame.height))
    thumbnail.contentMode = .scaleAspectFit
    thumbnail.image = image
    thumbnailScrollView.addSubview(thumbnail)
  }
}
