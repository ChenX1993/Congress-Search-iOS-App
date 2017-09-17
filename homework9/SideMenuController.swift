//
//  SideMenuController.swift
//  homework9
//
//  Created by ChenX on 18/11/2016.
//  Copyright © 2016 Evilsmile. All rights reserved.
//

import UIKit

class SideMenuController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBarController?.tabBar.isHidden = true
        //self.navigationController?.navigationBar.isHidden = true
        //tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if indexPath.row == 0 {
            UIApplication.shared.openURL(URL(string: "http://sunlightfoundation.com/")!)
        }
        if indexPath.row == 1 {
            var destinationVC: UITabBarController!
            destinationVC = storyboard.instantiateViewController(withIdentifier: "LegislatorTabBarController") as!LegislatorTabBarController
            sideMenuController()?.setContentViewController(destinationVC)
        }
        if indexPath.row == 2 {
            var destinationVC: UITabBarController!
            destinationVC = storyboard.instantiateViewController(withIdentifier: "BillTabBarController") as!BillTabBarController
            sideMenuController()?.setContentViewController(destinationVC)
        }
        if indexPath.row == 3 {
            var destinationVC: UITabBarController!
            destinationVC = storyboard.instantiateViewController(withIdentifier: "ComTabBarController") as!ComTabBarController
            sideMenuController()?.setContentViewController(destinationVC)
        }
        if indexPath.row == 4 {
            var destinationVC: UITabBarController!
            destinationVC = storyboard.instantiateViewController(withIdentifier: "FavoriteTabBarController") as!FavoriteTabBarController
            sideMenuController()?.setContentViewController(destinationVC)
        }
        if indexPath.row == 5 {
            var destinationVC: UIViewController!
            destinationVC = storyboard.instantiateViewController(withIdentifier: "AboutController") as! AboutController
            sideMenuController()?.setContentViewController(destinationVC)
        }

    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
