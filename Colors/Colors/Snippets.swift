//
//  ColorsCollectionViewController.swift
//  Colors
//
//  Created by Cliff Panos on 2/18/20.
//  Copyright © 2020 Clifford Panos. All rights reserved.
//

import UIKit

#if false
 
// Collection

 override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
     
     coordinator.animate(alongsideTransition: { (context) in
         self.collectionView.collectionViewLayout = self.collectionViewLayout(for: size)
         self.collectionView.reloadSections(IndexSet(integer: 0))
     }, completion: nil)
     
     super.viewWillTransition(to: size, with: coordinator)
 }
 
 private func collectionViewLayout(for size: CGSize) -> UICollectionViewLayout {
     let medium = size.width > 300 && size.width <= 850
     let large = size.width > 850
     
     let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
     let item = NSCollectionLayoutItem(layoutSize: itemSize)
     
     let columnCount = large ? 3 : (medium ? 2 : 1)
     let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(175))
     let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columnCount)
     group.interItemSpacing = .fixed(large ? 20 : 16)
     
     let section = NSCollectionLayoutSection(group: group)
     
     let constantInset: CGFloat = large ? 50 : (medium ? 16 : 16)
     section.contentInsets = NSDirectionalEdgeInsets(top: constantInset / 2.0, leading: constantInset, bottom: constantInset, trailing: constantInset)
     section.interGroupSpacing = group.interItemSpacing!.spacing
     
     return UICollectionViewCompositionalLayout(section: section)
 }

//Detail

class func present(over presenter: UIViewController,
                   completion: ((Color?) -> Void)?) {
    
    let navigationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateColorViewControllerNavigation") as! UINavigationController
    
    let colorController = navigationVC.viewControllers.first as! CreateColorViewController
    colorController.completion = completion
    
    presenter.present(navigationVC, animated: true, completion: nil)
}
 
#endif
