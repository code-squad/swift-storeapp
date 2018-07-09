//
//  StoreTableViewController.swift
//  StoreApp
//
//  Created by rk on 2018. 7. 8..
//  Copyright © 2018년 fryb. All rights reserved.
//

import UIKit

class StoreTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let storeModel = StoreModel()
        let storeItemArray = storeModel.decodeJsonToStoreItemArray()
        return storeItemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreItemCell", for: indexPath) as! StoreItemCell
//        // Configure the cell...
//        cell.itemTitleLabel.text = itemArray[indexPath.row].title
//        cell.itemDescriptionLabel.text = itemArray[indexPath.row].description
//        cell.itemPriceLabel.text = itemArray[indexPath.row].s_price
//        cell.itemSalePriceLabel.text = itemArray[indexPath.row].s_price
//        // badge 개수에 따라 ui처리
//        if(itemArray[indexPath.row].badge != nil){
//            // badge 1개 이상
//            cell.itemBadgeLabel1.text = itemArray[indexPath.row].badge?[0]
//            if((itemArray[indexPath.row].badge?.count)! > 1){
//                cell.itemBadgeLabel2.text = itemArray[indexPath.row].badge?[1]
//            }
//            else{
//                cell.itemBadgeLabel2.isHidden = true
//            }
//        }
//        else{
//            // badge 0개. 안보이게 처리.
//            cell.itemBadgeLabel1.isHidden = true
//            cell.itemBadgeLabel2.isHidden = true
//        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //고정 셀높이
        return 160;
        //동적으로하려면 오토레이아웃으로 커스텀 셀 설정해야함
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
