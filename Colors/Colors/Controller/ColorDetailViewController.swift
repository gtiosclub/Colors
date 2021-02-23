//
//  ColorDetailViewController.swift
//  Colors
//
//  Created by Cliff Panos on 2/18/20.
//  Copyright © 2020 Clifford Panos. All rights reserved.
//

import UIKit

class ColorDetailViewController: UIViewController {
    
    // MARK: - Public
    
    public var color: Color = Color(name: "No Color Selected", color: .clear)
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentView.layer.cornerRadius = 16
        self.contentView.layer.cornerCurve = .continuous
        
        self.contentView.backgroundColor = self.color.color
        self.navigationItem.title = color.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        #if targetEnvironment(macCatalyst)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        #endif
    }
    
    
    // MARK: - Private
    
    @IBOutlet private weak var contentView: UIView!
    
}

