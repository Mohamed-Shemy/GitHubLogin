//
//  UITableView + Extensions.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import UIKit

extension UITableView {
    
    func register<Cell: UITableViewCell>(nib cell: Cell.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.identifier)
    }
    
    func register<Cell: UITableViewCell>(class cell: Cell.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }
    
    func dequeue<Cell: UITableViewCell>() -> Cell {
        let id = Cell.identifier
        guard let cell = dequeueReusableCell(withIdentifier: id) as? Cell
        else { fatalError("Cannot dequeue cell with identifier '\(id)'") }
        return cell
    }
}
