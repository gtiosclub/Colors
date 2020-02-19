//
//  CreateColorViewController.swift
//  Colors
//
//  Created by Cliff Panos on 2/18/20.
//  Copyright © 2020 Clifford Panos. All rights reserved.
//

import UIKit

class CreateColorViewController: UIViewController {
    
    // MARK: - Class
    
    class func present(over presenter: UIViewController,
                       completion: ((Color?) -> Void)?) {
        
        let navigationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateColorViewControllerNavigation") as! UINavigationController
        
        let colorController = navigationVC.viewControllers.first as! CreateColorViewController
        colorController.completion = completion
        
        presenter.present(navigationVC, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateColor()
        self.colorView.layer.cornerRadius = 25
        self.colorView.layer.cornerCurve = .continuous
    }
    
    
    // MARK: - Private
    
    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var redSlider: UISlider!
    @IBOutlet private weak var blueSlider: UISlider!
    @IBOutlet private weak var greenSlider: UISlider!
    
    private var currentColor: UIColor {
        let red = CGFloat(redSlider.value) / 255.0
        let green = CGFloat(greenSlider.value) / 255.0
        let blue = CGFloat(blueSlider.value) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    @IBAction private func updateColor() {
        self.colorView.backgroundColor = self.currentColor
    }

    @IBAction private func savePressed(_ sender: Any?) {
        if let completion = completion {
            let newColor = Color(name: "New!", color: self.currentColor)
            completion(newColor)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction private func cancelPressed(_ sender: Any?) {
        if let completion = completion {
            completion(nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Private
    
    private var completion: ((Color?) -> Void)?

}
