//
//  SideNavigationController.swift
//  homework9
//
//  Created by ChenX on 18/11/2016.
//  Copyright © 2016 Evilsmile. All rights reserved.
//

import UIKit

class SideNavigationController: ENSideMenuNavigationController {

    override func viewDidLoad() {
        //super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menu = storyboard.instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: menu, menuPosition: ENSideMenuPosition.left)
        sideMenu?.menuWidth = 250
        view.bringSubview(toFront: navigationBar)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
