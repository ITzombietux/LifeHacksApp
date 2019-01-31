//
//  SettingsViewController.swift
//  LifeHacksApp
//
//  Created by zombietux on 12/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, Stateful {

   @IBOutlet var cells: [UITableViewCell]!
    
    var stateController: StateController?
    var settingsController: SettingsController?
    var uploadNotificationCenter: NotificationCenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        select(cell: selectedSchemeCell)
        applyStyle()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellIndex = indexPath.row
        settingsController?.scheme = cellIndex == 0 ? .defaultScheme : .webScheme
        let cell = cells[cellIndex]
        select(cell: cell)
        applyStyle()
    }
}

private extension SettingsViewController {
    var selectedSchemeCell: UITableViewCell {
        switch settingsController?.scheme {
        case ColorScheme.webScheme: return cells[1]
        default: return cells[0]
        }
    }
    
    func select(cell: UITableViewCell) {
        for staticCell in cells {
            staticCell.accessoryType = staticCell === cell ? .checkmark : .none
        }
    }
    
    func applyStyle() {
        guard let scheme = settingsController?.scheme else {
            return
        }
        for cell in cells {
            cell.textLabel?.textColor = scheme.titleColor
            cell.tintColor = scheme.buttonColor
        }
    }
}
