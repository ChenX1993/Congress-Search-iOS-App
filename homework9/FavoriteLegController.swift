//
//  LegHouseController.swift
//  homework9
//
//  Created by ChenX on 18/11/2016.
//  Copyright © 2016 Evilsmile. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class FavoriteLegController: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
//    var array1 = [String]()
//    var dic = [String : Array<JSON>]()
    var array = [JSON]()
    var array1 = [JSON]()
    var searchButton = UIBarButtonItem()
    var stopButton = UIBarButtonItem()
    let url = URL(string:"http://104.198.0.197:8080/legislators?apikey=a32d292fdb6d4943a24e2b3d6ad53f9d&per_page=all")!
    var searchController : CustomSearchController! //UISearchController!
    @IBAction func MenuButtonTapped(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
    }
//    @IBAction func searchTapped(_ sender: UIBarButtonItem) {
//        if(self.navigationItem.titleView == nil){
//            self.navigationItem.titleView = searchController.searchBar
//            let item1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop,target: self, action: searchTapped())
//            //var style:UIBarButtonItemStyle{set}
//            //print(self.navigationItem.rightBarButtonItem?.style.hashValue)//: UIBarButtonItemStyle{set}
//            self.navigationItem.rightBarButtonItem = item1
//        }
//        else{
//            self.navigationItem.titleView = nil
//        }
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.searchController = CustomSearchController(searchResultsController:nil) //UISearchController(searchResultsController:nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.searchBar.sizeToFit()
        //self.navigationItem.titleView = searchController.searchBar
        self.definesPresentationContext = true
        searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search,target: self, action: "searchButtonTapped")
        stopButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop,target: self, action: "stopButtonTapped")
        self.navigationItem.rightBarButtonItem = searchButton
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
                    for j in json["results"].arrayValue {
                        if(databasecontroller.searchInLeg(string:j["bioguide_id"].stringValue) > 0){
                            self.array.append(j)
                        }
                    }
                    //self.array = json["results"].arrayValue
                    self.array = self.array.sorted(){$1["last_name"].stringValue > $0["last_name"].stringValue}
                    self.array = self.array.sorted(){$1["first_name"].stringValue > $0["first_name"].stringValue}
                    self.array1 = self.array
                    self.tableView.reloadData()
                }
            case false:
                print(response.result.error!)
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func searchButtonTapped(){
        self.navigationItem.titleView = searchController.searchBar
        self.navigationItem.rightBarButtonItem = stopButton
    }
    
    func stopButtonTapped(){
        self.navigationItem.titleView = nil
        self.searchController.isActive = false
        self.navigationItem.rightBarButtonItem = searchButton
        array1 = array
        self.tableView.reloadData()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForTable(searchText: searchController.searchBar.text!)
        self.tableView.reloadData()
    }
    func filterContentForTable(searchText: String, scope: String = "All"){
        if(searchText == ""){
            self.array1 = self.array
        }
        else{
            self.array1 = self.array.filter{x in
                return x["first_name"].stringValue.lowercased().contains(searchText.lowercased())||x["last_name"].stringValue.lowercased().contains(searchText.lowercased())
            }
        }
                //print(searchText.lowercased())
        self.tableView.reloadData()
    }
//    func didPresentSearchController(_ searchController: UISearchController) {
//        searchController.searchBar.showsCancelButton = false
//    }

    // MARK: - Table view data source
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let searchText = searchBar.text!
        self.searchController.isActive = false
        searchBar.text = searchText
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        if (searchController.isActive && (searchController.searchBar.text! != "") ){
//            return array1.count
//        }
        return array1.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        var content:JSON = array1[indexPath.row]
//        if (searchController.isActive && (searchController.searchBar.text! != "")){
//            content = array1[indexPath.row]
//        }
//        else{
//            content = array[indexPath.row]
//        }
        cell.textLabel?.text = content["first_name"].stringValue+" "+content["last_name"].stringValue
        cell.detailTextLabel?.text = content["state_name"].stringValue
        let urls = "http://theunitedstates.io/images/congress/original/"+content["bioguide_id"].stringValue+".jpg"
        let url = NSURL(string:urls)
        let data_img = NSData(contentsOf:url! as URL)
        cell.imageView?.image = UIImage(data:data_img! as Data)
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewcontroller = storyboard.instantiateViewController(withIdentifier: "favotiteLegDetail") as!LegislatorDetailController
        viewcontroller.jsondetail = array1[indexPath.row]
        self.navigationController?.pushViewController(viewcontroller, animated: true)
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
