//
//  ColorViewController.swift
//  Spec
//
//  Created by Brian Wang on 3/27/17.
//  Copyright © 2017 GT. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    
    var color:UIColor!
    var colorName:String!
    
    var showColor = false
    
    @IBOutlet weak var colorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorLabel.textColor = color
        colorLabel.text = colorName
        self.navigationItem.title = colorName
    }

    @IBAction func handletap(_ sender: UITapGestureRecognizer) {
        if (!showColor) {
            self.view.backgroundColor = color
            colorLabel.textColor = UIColor.white
        } else {
            self.view.backgroundColor = UIColor.white
            colorLabel.textColor = color
        }
        showColor = !showColor
    }

}
