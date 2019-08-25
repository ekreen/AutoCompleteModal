//
//  AutoCompleteDelegate.swift
//  AutoCompleteModal
//
//  Created by Kévin Esprit on 25/08/2019.
//  Copyright © 2019 Kespri. All rights reserved.
//

import UIKit

class AutoCompleteDelegate: NSObject {
    var autoCompleteDatas : [String] = []
    
    private var heightConstraint: NSLayoutConstraint!
    
    init(heightConstraint: NSLayoutConstraint) {
        self.heightConstraint = heightConstraint
        super.init()
    }
}


extension AutoCompleteDelegate: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoCompleteDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "identifierCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = autoCompleteDatas[indexPath.row]
        updateHeight(tableView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.isHidden = true
    }
}


extension AutoCompleteDelegate {
    func updateHeight(_ tableView: UITableView) {
        
        if heightConstraint != nil {
            heightConstraint.isActive = false
        }
        heightConstraint = tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height)
        heightConstraint.isActive = true
    }
}
