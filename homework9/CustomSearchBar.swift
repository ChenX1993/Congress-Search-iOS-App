//
//  CustomSearchBar.swift
//  homework9
//
//  Created by ChenX on 20/11/2016.
//  Copyright © 2016 Evilsmile. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func layoutSubviews() {
        super.layoutSubviews()
        setShowsCancelButton(false, animated: false)
    }

}
