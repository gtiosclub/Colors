//
//  ColorPickerViewController.swift
//  Spec
//
//  Created by Cal Stephens on 4/3/17.
//  Copyright © 2017 GT. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {
    
    
    //MARK: - Presentation
    
    static func present(over presenter: UIViewController, completion: @escaping ((color: UIColor, name: String)?) -> ()) {
        let navigation = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "colorPickerNavigation") as! UINavigationController
        
        let colorController = navigation.childViewControllers.first as! ColorPickerViewController
        colorController.completion = completion
        
        presenter.present(navigation, animated: true, completion: nil)
    }
    
    
    //MARK: - Properties
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    var completion: (((UIColor, String)?) -> ())?
    
    var currentColor: UIColor {
        let red = CGFloat(redSlider.value) / 256
        let green = CGFloat(greenSlider.value) / 256
        let blue = CGFloat(blueSlider.value) / 256
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        self.colorView.backgroundColor = self.currentColor
    }
    
    
    //MARK: - User Interaction
    
    @IBAction func updateColor() {
        self.colorView.backgroundColor = self.currentColor
    }
    
    @IBAction func donePressed(_ sender: Any) {
        
        //now we have to ask for the name
        let alert = UIAlertController(title: "Name your new Color", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Purple"
            textField.autocapitalizationType = .sentences
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
            
            guard let colorName = alert.textFields?.first?.text, !colorName.isEmpty else {
                //if there was no color name, prompt them again
                self.donePressed(sender)
                return
            }
            
            self.completion?((color: self.currentColor, name: colorName))
            self.dismiss(animated: true, completion: nil)
        
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.completion?(nil)
        self.dismiss(animated: true, completion: nil)
    }
    
}
