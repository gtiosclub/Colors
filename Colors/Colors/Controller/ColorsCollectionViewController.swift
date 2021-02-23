//
//  ColorsCollectionViewController.swift
//  Colors
//
//  Created by Cliff Panos on 2/18/20.
//  Copyright © 2020 Clifford Panos. All rights reserved.
//

import UIKit

class ColorsCollectionViewController: UICollectionViewController {

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let frame = CGSize(width:  self.splitViewController?.preferredPrimaryColumnWidth ?? 0, height: self.view.frame.size.height)
        self.collectionView.collectionViewLayout = self.collectionViewLayout(for: frame)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "newColorTapped"), object: nil, queue: .main) { [weak self] (_) in
            self?.didTapCreateColor(nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        #if targetEnvironment(macCatalyst)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        #endif
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "newColorTapped"), object: nil)
        super.viewDidDisappear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (context) in
            self.collectionView.collectionViewLayout = self.collectionViewLayout(for: size)
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }, completion: nil)
        
        super.viewWillTransition(to: size, with: coordinator)
    }

    
    // MARK: - Navigation using the prepare(for:sender:) pattern

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? ColorDetailViewController {
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
    
    
    // MARK: - Navigation using a static presenter + completion handler pattern
    
    @IBAction private func didTapCreateColor(_ sender: UIBarButtonItem?) {
        CreateColorViewController.present(over: self, completion: { color in
            if let createdColor = color {
                self.colors.append(createdColor)
                self.collectionView.insertItems(at: [IndexPath(row: self.colors.count - 1, section: 0)])
            }
            self.presentedViewController?.dismiss(animated: true, completion: nil)
        })
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ColorCollectionViewCell
    
        cell.decorate(for: self.colors[indexPath.row])
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "Detail") as! ColorDetailViewController
        detailVC.color = self.colors[indexPath.row]
        self.splitViewController?.showDetailViewController(detailVC, sender: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 contextMenuConfigurationForItemAt indexPath: IndexPath,
                                 point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            let inspectAction =
                        UIAction(title: "Open",
                                 image: UIImage(systemName: "arrow.up.square")) { action in
                            self.collectionView(collectionView, didSelectItemAt: indexPath)
                        }
                        
                    let duplicateAction =
                        UIAction(title: "Duplicate",
                                 image: UIImage(systemName: "plus.square.on.square")) { action in
                            let createdColor = self.colors[indexPath.row]
                            self.colors.append(createdColor)
                            self.collectionView.insertItems(at: [IndexPath(row: self.colors.count - 1, section: 0)])
                        }
                        
                    let deleteAction =
                        UIAction(title: "Delete",
                                 image: UIImage(systemName: "trash"),
                                 attributes: .destructive) { action in
                           
                        }
            return UIMenu(title: "", children: [inspectAction, duplicateAction, deleteAction])
        }
    }
    
    
    // MARK: - Private
    
    private let reuseIdentifier = "ColorCell"
    
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
    
    private var colors: [Color] = [
        Color(name: "First",  color: .systemBlue),
        Color(name: "Second", color: .systemTeal),
        Color(name: "Third",  color: .systemPink),
        Color(name: "Fourth", color: .systemGreen),
    ]

}


// MARK: - ColorCollectionViewCell

public class ColorCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Lifecycle
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 16
        self.contentView.layer.cornerCurve = .continuous
    }
    
    
    // MARK: - Public
    
    public func decorate(for color: Color) {
        self.contentView.backgroundColor = color.color
        self.colorTitleLabel.text = color.name
    }
    
    
    // MARK: - UICollectionViewCell
    
    public override var isHighlighted: Bool {
        didSet {
            let scale: CGFloat = 0.95
            let scaleTransform: CGAffineTransform = CGAffineTransform(scaleX: scale, y: scale)
            
            let duration: TimeInterval = 0.19
            UIView.animate(withDuration: duration) {
                self.transform = self.isHighlighted ? scaleTransform : .identity
            }
        }
    }
    
    
    // MARK: - Private
    
    @IBOutlet private weak var colorTitleLabel: UILabel!
    
}
