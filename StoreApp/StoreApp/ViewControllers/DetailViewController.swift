//
//  DetailViewController.swift
//  StoreApp
//
//  Created by yuaming on 17/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

protocol OrderDelegate: class {
  func showResult(_ orderInfo: OrderInfo)
}

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
  
  fileprivate let detailSectionHeight: CGFloat = 500
  
  var itemDetail: StoreDetailItem?
  var orderDelegate: OrderDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setupObservers()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  fileprivate func setup() {
    self.itemDetail?.requestData()
    self.navigationController?.isNavigationBarHidden = true
  }
  
  fileprivate func setupObservers() {
    NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: .detailData, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(updateThumbnails(_:)), name: .thumbnail, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(updateDetailSection(_:)), name: .detailSection, object: nil)
  }
  
  @objc fileprivate func updateData(_ notification: Notification) {
    guard let userInfo = notification.userInfo,
      let detailTitle = userInfo[Constants.detailTitle] as? String,
      let itemDetailData = userInfo[Constants.detailData] as? ItemDetailData else { return }
    
    configueSectionScrollViewSize(itemDetailData.detailSectionImageUrls.count)
    configueThumbnailScrollViewSize(itemDetailData.thumbnailImageUrls.count)
    updateDetailInfoContainer(detailTitle, itemDetailData)
  }
  
  @objc fileprivate func updateThumbnails(_ notification: Notification) {
    guard let userInfo = notification.userInfo,
      let index = userInfo[Constants.imageIndex] as? Int,
      let image = userInfo[Constants.image] as? UIImage else { return }
    
    DispatchQueue.main.async {
      self.updateThumbnailScrollView(index: index, image: image)
    }
  }
  
  @objc fileprivate func updateDetailSection(_ notification: Notification) {
    guard let userInfo = notification.userInfo,
      let index = userInfo[Constants.imageIndex] as? Int,
      let image = userInfo[Constants.image] as? UIImage else { return }
    
    DispatchQueue.main.async {
      self.updateDetailSectionView(index: index, image: image)
    }
  }
  
  @IBAction func orderButtonDidTapped(_ sender: UIButton) {
    let orderInfo = OrderInfo(name: "AMING", menu: titleLabel.text ?? "", price: priceLabel.text ?? "")
    
    guard let url = API.shared.makeUrl("\(Host.order.path)") else { return }
    guard let orderResultData = JSONConverter.encode(in: [Constants.text : orderInfo.description]) else { return }
    
    API.shared.post(withUrl: url, data: orderResultData)
    orderDelegate?.showResult(orderInfo)
    self.navigationController?.popViewController(animated: true)
  }
}

fileprivate extension DetailViewController {
  func configueSectionScrollViewSize(_ count: Int) {
    sectionScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,
                                           height: thumbnailScrollView.frame.height +         detailInfoContainer.frame.height + detailSectionHeight * CGFloat(count))
  }
  
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
    let thumbnailView = UIImageView(frame: CGRect(x: xCoordinate, y: 0, width: UIScreen.main.bounds.width, height: thumbnailScrollView.frame.height))
    thumbnailView.contentMode = .scaleAspectFill
    thumbnailView.image = image
    thumbnailScrollView.addSubview(thumbnailView)
  }
  
  func updateDetailSectionView(index: Int, image: UIImage) {
    let yCoordinate: CGFloat = (thumbnailScrollView.frame.height + detailInfoContainer.frame.height) + (CGFloat(index) * detailSectionHeight)
    let detailSectionImageView = UIImageView(frame: CGRect(x: 0, y: yCoordinate, width: UIScreen.main.bounds.width, height: detailSectionHeight))
    detailSectionImageView.contentMode = .scaleAspectFit
    detailSectionImageView.image = image
    sectionScrollView.addSubview(detailSectionImageView)
  }
}
