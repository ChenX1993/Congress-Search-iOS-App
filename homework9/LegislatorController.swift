//
//  LegislatorController.swift
//  homework9
//
//  Created by ChenX on 14/11/2016.
//  Copyright © 2016 Evilsmile. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

extension String {
    subscript(i: Int) -> String {
        guard i >= 0 && i < characters.count else { return "" }
        return String(self[index(startIndex, offsetBy: i)])
    }
    subscript(range: Range<Int>) -> String {
        let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) ?? endIndex
        return substring(with: lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) ?? endIndex))
    }
    subscript(range: ClosedRange<Int>) -> String {
        let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) ?? endIndex
        return substring(with: lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) ?? endIndex))
    }
}

class LegislatorController: UITableViewController {
    var state:String = ""
    var array1 = [String]()
    var dic = [String : Array<JSON>]()
    let url = URL(string:"http://104.198.0.197:8080/legislators?apikey=a32d292fdb6d4943a24e2b3d6ad53f9d&per_page=all")!
    
    @IBAction func MenuButtonTapped(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
    }
    
    @IBAction func pickerTapped(_ sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
                    var legi = json["results"].arrayValue
                    if(self.state == "" || self.state == "All States"){
                        
                    }
                    else
                    {
                        legi = legi.filter{x in
                            return x["state_name"].stringValue == self.state
                        }

                    }
                    legi = legi.sorted(){$1["last_name"].stringValue > $0["last_name"].stringValue}
                    legi = legi.sorted(){$1["first_name"].stringValue > $0["first_name"].stringValue}
                    for j in legi{
                        let s = j["first_name"].stringValue
                        self.array1.append(String(s.characters.first!))
                    }
                    self.array1 = Array(Set(self.array1))
                    self.array1 = self.array1.sorted(){ $1 > $0 }
                    for  d in self.array1 {
                        self.dic.updateValue([], forKey: d)
                    }
                    for j in legi{
                        let s = j["first_name"].stringValue
                        let s1 = String(s.characters.first!)
                        (self.dic[s1])!.append(j)
                    }
                    
                    //print(self.array1)
                    //print(self.dic)
                    //let id = json["results"][0]["bioguide_id"].stringValue
                    self.tableView.reloadData()
                }
            case false:
                print(response.result.error!)
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        let legi = Legislators(context: databasecontroller.persistentContainer.viewContext)
//        legi.id = "555"
//        databasecontroller.saveContext()
//        databasecontroller.getContext().delete(legi)
//        databasecontroller.saveInLeg(string: "111")
//        databasecontroller.saveInLeg(string: "333")
//   print(databasecontroller.searchInLeg(string: "333"))

        printCoreData()
    }
    func printCoreData(){
        print("Legislator:")
        let fetchRequest:NSFetchRequest<Legislators> = Legislators.fetchRequest()
        do{
            let searchResults = try databasecontroller.getContext().fetch(fetchRequest)
            print("number of results:\(searchResults.count)")
            for result in searchResults as [Legislators]{
                print("\(result.id!)")
            }
        }
        catch{
        }
        print("")
        print("Bill:")
        let fetchRequest1:NSFetchRequest<Bills> = Bills.fetchRequest()
        do{
            let searchResults1 = try databasecontroller.getContext().fetch(fetchRequest1)
            print("number of results:\(searchResults1.count)")
            for result in searchResults1 as [Bills]{
                print("\(result.id!)")
            }
        }
        catch{
        }
        print("")
        print("Committees:")
        let fetchRequest2:NSFetchRequest<Committees> = Committees.fetchRequest()
        do{
            let searchResults2 = try databasecontroller.getContext().fetch(fetchRequest2)
            print("number of results:\(searchResults2.count)")
            for result in searchResults2 as [Committees]{
                print("\(result.id!)")
            }
        }
        catch{
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return array1
    }

    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return array1[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return array1.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dic[array1[section]]!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        let content=dic[array1[indexPath.section]]![indexPath.row]
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
        var viewcontroller = storyboard.instantiateViewController(withIdentifier: "LegislatorDetailController") as!LegislatorDetailController
        viewcontroller.jsondetail = dic[array1[indexPath.section]]![indexPath.row]
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
