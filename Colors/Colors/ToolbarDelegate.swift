//
//  ToolbarDelegate.swift
//  Colors
//
//  Created by Phil Zet on 2/4/21.
//  Copyright © 2021 Clifford Panos. All rights reserved.
//

import UIKit

class ToolbarDelegate: NSObject {
    
}

#if targetEnvironment(macCatalyst)

extension ToolbarDelegate {
    
    @objc
    func newColor(_ sender: Any?) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newColorTapped"), object: nil)
    }
    
    @objc
    func toggleIsFavorite(_ sender: Any?) {
        
    }
    
}

extension NSToolbarItem.Identifier {
    static let newColor = NSToolbarItem.Identifier("newColor")
    static let toggleIsFavorite = NSToolbarItem.Identifier("toggleIsFavorite")
}

extension ToolbarDelegate: NSToolbarDelegate {
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        let identifiers: [NSToolbarItem.Identifier] = [
            .toggleSidebar, .flexibleSpace, .showColors, .toggleIsFavorite, .newColor
        ]
        return identifiers
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarDefaultItemIdentifiers(toolbar)
    }
    
    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        var toolbarItem: NSToolbarItem?
        
        switch itemIdentifier {
        case .toggleSidebar, .flexibleSpace, .showColors:
            toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            
        case .newColor:
            let item = NSToolbarItem(itemIdentifier: itemIdentifier)
            item.image = UIImage(systemName: "square.and.pencil")
            item.label = "New Color"
            item.action = #selector(newColor(_:))
            item.target = self
            toolbarItem = item
            
        case .toggleIsFavorite:
            let item = NSToolbarItem(itemIdentifier: itemIdentifier)
            item.image = UIImage(systemName: "heart")
            item.label = "Toggle Favorite"
            item.action = #selector(toggleIsFavorite(_:))
            item.target = self
            toolbarItem = item
            
        default:
            toolbarItem = nil
        }
        
        return toolbarItem
    }
    
}
#endif
