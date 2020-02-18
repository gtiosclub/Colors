//
//  ColorsCollectionViewController.swift
//  Spec
//
//  Created by Cliff Panos on 10/23/18.
//  Copyright © 2018 GT. All rights reserved.
//

import UIKit

class ColorsCollectionViewController: UICollectionViewController {

    var colors: [UIColor] = []
    
    private let reuseIdentifier = "ColorCell"
    private let contentSpacing: CGFloat = 12.0
    
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.delegate = self

        // Do any additional setup after loading the view.
        colors = [UIColor.blue, UIColor.red, UIColor.orange, UIColor.green]
    }


    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Constant
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        cell.backgroundColor = self.colors[indexPath.row]
        cell.layer.cornerRadius = 10.0
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ColorDetail", sender: indexPath)
    }

    
    // MARK: - Navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? ColorViewController {
            let indexPath: IndexPath?
            if let cell = sender as? UICollectionViewCell {
                indexPath = self.collectionView!.indexPath(for: cell)
            } else {
                indexPath = sender as? IndexPath
            }
            
            if let indexPath = indexPath {
                detailVC.color = self.colors[indexPath.row]
            }
        }
    }
    
    @IBAction private func createColorPressed(_ sender: Any?) {
        ColorPickerViewController.present(over: self) { color in
            if let color = color {
                self.colors.append(color)
                self.collectionView!.reloadData()
            }
            self.presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }

}

extension ColorsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sectionInset = self.collectionView(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAt: 0)
        var availableBounds = UIEdgeInsetsInsetRect(collectionView.bounds, sectionInset)
        availableBounds = UIEdgeInsetsInsetRect(availableBounds, collectionView.safeAreaInsets)
        
        let spacing = self.contentSpacing
        let cellWidth = (availableBounds.width - spacing) / 2.0
        let cellHeight = cellWidth
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.contentSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.contentSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return  UIEdgeInsets(top: contentSpacing, left: contentSpacing, bottom: contentSpacing, right: contentSpacing)
    }
    
}
