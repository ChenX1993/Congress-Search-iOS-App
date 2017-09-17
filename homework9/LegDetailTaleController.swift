//
//  LegDetailTaleController.swift
//  homework9
//
//  Created by ChenX on 19/11/2016.
//  Copyright © 2016 Evilsmile. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class LegDetailTaleController: UITableViewController {
    var json: JSON = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //let par = self.parent as!LegislatorDetailController
        //let json:JSON = par.jsondetail
        //print(json)
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
        return 11
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(indexPath.row == 0){
            cell.textLabel?.text = "First Name"
            cell.detailTextLabel?.text = "      "+json["first_name"].stringValue
        }
        if(indexPath.row == 1){
            cell.textLabel?.text = "Last Name"
            cell.detailTextLabel?.text = "      "+json["last_name"].stringValue
        }
        if(indexPath.row == 2){
            cell.textLabel?.text = "State"
            cell.detailTextLabel?.text = "      "+json["state_name"].stringValue
        }
        if(indexPath.row == 3){
            cell.textLabel?.text = "Birth date"
            if let birth = json["birthday"].string {
               cell.detailTextLabel?.text = "      "+birth
            }
            else{
                cell.detailTextLabel?.text = "      "+"invalid"
            }
        }
        if(indexPath.row == 4){
            cell.textLabel?.text = "Gender"
            if let gender = json["gender"].string {
                if(gender == "M"){
                    cell.detailTextLabel?.text = "      "+"Male"
                }
                else{
                   cell.detailTextLabel?.text = "      "+"Female"
                }
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
            cell.textLabel?.text = "Fax No."
            if let fax = json["fax"].string {
                if(fax == ""){
                    cell.detailTextLabel?.text = "      "+"N.A."
                }
                else{
                    cell.detailTextLabel?.text = "      "+fax
                }
            }
            else{
                cell.detailTextLabel?.text = "      "+"N.A."
            }
        }
        if(indexPath.row == 7){
            cell.textLabel?.text = "Twitter"
            if let twitter = json["twitter_id"].string {
                if(twitter == ""){
                    cell.detailTextLabel?.text = "      "+"N.A."
                }
                else{
                    cell.detailTextLabel?.textColor = UIColor.blue
                    cell.detailTextLabel?.text = "      "+"Twitter Link"
                }
            }
            else{
                cell.detailTextLabel?.text = "      "+"N.A."
            }
        }
        if(indexPath.row == 8){
            cell.textLabel?.text = "Website"
            if let website = json["website"].string {
                if(website == ""){
                    cell.detailTextLabel?.text = "      "+"N.A."
                }
                else{
                    cell.detailTextLabel?.textColor = UIColor.blue
                    cell.detailTextLabel?.text = "      "+"Website Link"
                }
            }
            else{
                cell.detailTextLabel?.text = "      "+"N.A."
            }
        }
        if(indexPath.row == 9){
            cell.textLabel?.text = "Office No."
            if let office = json["office"].string {
                if(office == ""){
                    cell.detailTextLabel?.text = "      "+"N.A."
                }
                else{
                    cell.detailTextLabel?.text = "      "+office
                }
            }
            else{
                cell.detailTextLabel?.text = "      "+"N.A."
            }
        }
        if(indexPath.row == 10){
            cell.textLabel?.text = "Term ends on"
            if let termendson = json["term_end"].string {
                if(termendson == ""){
                    cell.detailTextLabel?.text = "      "+"N.A."
                }
                else{
                    cell.detailTextLabel?.text = "      "+termendson
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
        if(indexPath.row == 7){
            if let twitter = json["twitter_id"].string{
                let url: String = "http://twitter.com/"+twitter
                UIApplication.shared.openURL(URL(string: url)!)
            }
        }
        if(indexPath.row == 8){
            if let website = json["website"].string{
                let url: String = website
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
