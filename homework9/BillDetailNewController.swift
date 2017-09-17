//
//  BillDetailActiveController.swift
//  homework9
//
//  Created by ChenX on 21/11/2016.
//  Copyright © 2016 Evilsmile. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class BillDetailNewController: UIViewController {
    
    
    @IBOutlet weak var textcontent: UITextView!
    var jsondetail: JSON = []
    var starButton = UIBarButtonItem()
    var staroButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        let button1 = UIButton.init(type: .custom)
        button1.setImage(UIImage.init(named: "star.png"), for: UIControlState.normal)
        button1.addTarget(self, action:"starButtonTapped", for:UIControlEvents.touchUpInside)
        button1.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        starButton = UIBarButtonItem.init(customView: button1)
        
        let button2 = UIButton.init(type: .custom)
        button2.setImage(UIImage.init(named: "staro.png"), for: UIControlState.normal)
        button2.addTarget(self, action:"staroButtonTapped", for:UIControlEvents.touchUpInside)
        button2.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30) //CGRectMake(0, 0, 30, 30)
        staroButton = UIBarButtonItem.init(customView: button2)
        
        if(databasecontroller.searchInBill(string: jsondetail["bill_id"].stringValue) == 0){
            self.navigationItem.rightBarButtonItem = staroButton
            
        }
        else{
            self.navigationItem.rightBarButtonItem = starButton
        }
        textcontent.text = jsondetail["official_title"].stringValue
        textcontent.isEditable = false
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if(segue.identifier == "to2"){
                let detail:BillDetailTableController = segue.destination as! BillDetailTableController
                detail.json = jsondetail
            }
        }
    func starButtonTapped(){
        self.navigationItem.rightBarButtonItem = staroButton
        databasecontroller.deleteInBill(string: jsondetail["bill_id"].stringValue)
    }
    
    func staroButtonTapped(){
        self.navigationItem.rightBarButtonItem = starButton
        databasecontroller.saveInBill(string: jsondetail["bill_id"].stringValue)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
