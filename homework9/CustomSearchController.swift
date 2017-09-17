//
//  CustomSearchController.swift
//  homework9
//
//  Created by ChenX on 20/11/2016.
//  Copyright © 2016 Evilsmile. All rights reserved.
//

import UIKit

class CustomSearchController: UISearchController , UISearchBarDelegate{

    lazy var _searchBar: CustomSearchBar = {
        [unowned self] in
        let result = CustomSearchBar()
        result.delegate = self
        
        return result
    }()
    
    override var searchBar: UISearchBar {
        get {
            return _searchBar
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
