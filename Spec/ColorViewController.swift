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
    
    @IBOutlet private weak var label: UILabel!
    private var showColor = true
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = color
        self.label.textColor = .white
    }
    
    
    // MARK: - UITapGestureRecognizer

    @IBAction func handletap(_ sender: UITapGestureRecognizer) {
        if (!showColor) {
            self.view.backgroundColor = color
            label.textColor = UIColor.white
        } else {
            self.view.backgroundColor = UIColor.white
            label.textColor = color
        }
        showColor = !showColor
    }

}
