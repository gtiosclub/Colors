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
