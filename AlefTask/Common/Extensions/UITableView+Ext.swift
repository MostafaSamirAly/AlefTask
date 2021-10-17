//
//  UITableView+Ext.swift
//  AlefTask
//
//  Created by Mostafa Samir on 17/10/2021.
//

import UIKit

extension UITableView {
    
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type) {
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }
}
