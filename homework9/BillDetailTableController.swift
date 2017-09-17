//
//  BillDetailTableController.swift
//  homework9
//
//  Created by ChenX on 21/11/2016.
//  Copyright © 2016 Evilsmile. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class BillDetailTableController: UITableViewController {
    var json: JSON = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 8
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(indexPath.row == 0){
            cell.textLabel?.text = "Bill ID"
            cell.detailTextLabel?.text = "      "+json["bill_id"].stringValue
        }
        if(indexPath.row == 1){
            cell.textLabel?.text = "Bill Type "
            cell.detailTextLabel?.text = "      "+json["bill_type"].stringValue.uppercased()
        }
        if(indexPath.row == 2){
            cell.textLabel?.text = "Sponsor"
            if let sponsor = json["sponsor"].array {
                cell.detailTextLabel?.text = "      "+json["sponsor"]["title"].stringValue+" "+json["sponsor"]["first_name"].stringValue+" "+json["sponsor"]["last_name"].stringValue
            }
            else{
                cell.detailTextLabel?.text = "      "+"N.A."
            }
        }
        if(indexPath.row == 3){
            cell.textLabel?.text = "Last Action"
            if let last = json["last_action_at"].string {
                cell.detailTextLabel?.text = "      "+last
            }
            else{
                cell.detailTextLabel?.text = "      "+"N.A."
            }
        }
        if(indexPath.row == 4){
            cell.textLabel?.text = "PDF"
            if let pdf = json["last_version"]["urls"]["pdf"].string {
                cell.detailTextLabel?.text = "      "+"PDF Link"
                cell.detailTextLabel?.textColor = UIColor.blue
            }
            else{
                cell.detailTextLabel?.text = "      "+"N.A."
            }
        }
        if(indexPath.row == 5){
            cell.textLabel?.text = "Chamber"
            if let chamber = json["chamber"].string {
                if(chamber == "house"){
                    cell.detailTextLabel?.text = "      "+"House"
                }
                else if(chamber == "senate"){
                    cell.detailTextLabel?.text = "      "+"Senate"
                }
                else{
                    cell.detailTextLabel?.text = "      "+"Joint"
                }
            }
            else{
                cell.detailTextLabel?.text = "      "+"N.A."
            }
        }
        if(indexPath.row == 6){
            cell.textLabel?.text = "Last Vote"
            if let vote = json["last_vote"].string {
                if(vote == "null"){
                    cell.detailTextLabel?.text = "      "+"N.A."
                }
                else{
                    cell.detailTextLabel?.text = "      "+vote
                }
            }
            else{
                cell.detailTextLabel?.text = "      "+"N.A."
            }
        }
        if(indexPath.row == 7){
            cell.textLabel?.text = "Status"
            if let status = json["history"]["active"].bool {
                if(status == true){
                    cell.detailTextLabel?.text = "      "+"Active."
                }
                else{
                    cell.detailTextLabel?.text = "      "+"New"
                }
            }
            else{
                cell.detailTextLabel?.text = "      "+"N.A."
            }
        }

        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 4){
            if let pdf = json["last_version"]["urls"]["pdf"].string{
                let url: String = pdf
                UIApplication.shared.openURL(URL(string: url)!)
            }
        }
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
