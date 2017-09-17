//
//  ComHouseDetailControllerViewController.swift
//  homework9
//
//  Created by ChenX on 21/11/2016.
//  Copyright © 2016 Evilsmile. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class ComHouseDetailController: UIViewController {
    var jsondetail: JSON = []
    var starButton = UIBarButtonItem()
    var staroButton = UIBarButtonItem()
    
    @IBOutlet weak var a: UILabel!
    
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
        
        if(databasecontroller.searchInCom(string: jsondetail["committee_id"].stringValue) == 0){
            self.navigationItem.rightBarButtonItem = staroButton
            
        }
        else{
            self.navigationItem.rightBarButtonItem = starButton
        }
        a.text = jsondetail["name"].stringValue
        a.numberOfLines = 0
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "to1"){
            let detail:ComDetailTableController = segue.destination as! ComDetailTableController
            detail.json = jsondetail
        }
    }
    func starButtonTapped(){
        self.navigationItem.rightBarButtonItem = staroButton
        databasecontroller.deleteInCom(string: jsondetail["committee_id"].stringValue)
    }
    
    func staroButtonTapped(){
        self.navigationItem.rightBarButtonItem = starButton
        databasecontroller.saveInCom(string: jsondetail["committee_id"].stringValue)
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
