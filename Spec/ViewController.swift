//
//  ViewController.swift
//  Spec
//
//  Created by Brian Wang on 3/27/17.
//  Copyright © 2017 GT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var colors:[ColorSpec] = [ColorSpec.init(colorName: "Red", color: UIColor.red),
                              ColorSpec.init(colorName: "Blue", color: UIColor.blue),
                              ColorSpec.init(colorName: "Green", color: UIColor.green)]
    var filteredcolors = [ColorSpec]()
    var filterring = false
    
    var search: UISearchController?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        search = UISearchController(searchResultsController: nil)
        search?.searchResultsUpdater = self
        search?.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (filterring) {
            return filteredcolors.count
        }
        return colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath)
        
        let colorSpec : ColorSpec?
        
        if (filterring) {
            colorSpec = filteredcolors[indexPath.row]
        } else {
            colorSpec = colors[indexPath.row]
        }

        cell.textLabel?.text = colorSpec?.colorName
        cell.textLabel?.textColor = colorSpec?.color
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "Color", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ColorViewController
        let index = sender as! Int
        dest.color = colors[index].color
        dest.colorName = colors[index].colorName
    }

    @IBAction func addNewColor(_ sender: Any) {
        ColorPickerViewController.present(over: self, completion: { newColorInfo in
            if let newColor = newColorInfo?.color, let newName = newColorInfo?.name {
                let newColorSpec = ColorSpec.init(colorName: newName, color: newColor)
                self.colors.append(newColorSpec)
                self.tableView.reloadData()
            }
        })
    }
}

struct ColorSpec {
    let colorName: String
    let color: UIColor
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            self.filteredcolors = self.colors.filter({ (color) -> Bool in
                return color.colorName.lowercased().contains(text.lowercased())
            })
            self.filterring = true
        }
        else {
            self.filterring = false
            self.filteredcolors = []
        }
        self.tableView.reloadData()
    }
}

