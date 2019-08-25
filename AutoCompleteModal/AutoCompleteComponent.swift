//
//  AutoCompleteDelegate.swift
//  AutoCompleteModal
//
//  Created by Kévin Esprit on 25/08/2019.
//  Copyright © 2019 Kespri. All rights reserved.
//

import UIKit

class AutoCompleteComponent: NSObject {
    
    // MARK: - Properties
    
    var datas: [String]! {
        didSet {
            reloadTableView()
        }
    }
    private var autoCompleteDatas : [String] = []
    private var heightConstraint: NSLayoutConstraint!
    private var tableView: UITableView!
    
    init(heightConstraint: NSLayoutConstraint, tableView: UITableView) {
        super.init()
        self.heightConstraint = heightConstraint
        self.tableView = tableView
        self.prepareTableView()
        self.datas = []
    }
}

// MARK: - Tableview delegate & datasource
extension AutoCompleteComponent: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoCompleteDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "autoCompleteCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = autoCompleteDatas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.isHidden = true
    }
}


// MARK: - Textfield delegate
extension AutoCompleteComponent: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        tableView.isHidden = true
        
        guard var text = textField.text else {
            return true
        }
        
        if text.count > range.lowerBound {
            text.removeLast()
        } else {
            text.append(string)
        }
        
        guard text.count > 2 else {
            return true
        }
        
        autoCompleteDatas = datas.filter {
            $0.uppercased().contains(text.uppercased())
        }
        
        reloadTableView()
        tableView.isHidden = false
        return true
    }
}

// MARK: - Private functions
private extension AutoCompleteComponent {
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "autoCompleteCell")
    }
    
    func reloadTableView() {
        tableView.reloadData()
        updateHeight()
    }
    
    func updateHeight() {
        
        if heightConstraint != nil {
            heightConstraint.isActive = false
        }
        heightConstraint = tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height)
        heightConstraint.isActive = true
    }
}
