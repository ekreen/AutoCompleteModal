//
//  ModalViewController.swift
//  AutoCompleteModal
//
//  Created by Kévin Esprit on 25/08/2019.
//  Copyright © 2019 Kespri. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var modalView: UIView!
    
    // MARK: - Properties
    private var firstTableView: UITableView!
    private var heightConstraint: NSLayoutConstraint!
    private var autoCompleteComponent: AutoCompleteComponent!
    private let datas = ["Tomato","Orange","Lemon","Pineapple","Apple","Peach","Banana","Cherry","Olive","Kiwifruit","Blackberry","Papaya"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    @IBAction func okButtonPushed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

private extension ModalViewController {
    
    func setupUI() {
        setupTableView()
        setupTextField()
        setupModal()
    }
    
    func setupModal() {
        modalView.layer.cornerRadius = 15
    }
    
    func setupTextField() {
        firstTextField.delegate = autoCompleteComponent
    }
    
    func setupTableView() {
        firstTableView = UITableView()
        firstTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstTableView)
        firstTableView.isHidden = true
        
        // Constraints
        firstTableView.topAnchor.constraint(equalTo: firstTextField.bottomAnchor).isActive = true
        firstTableView.leadingAnchor.constraint(equalTo: firstTextField.leadingAnchor).isActive = true
        firstTableView.trailingAnchor.constraint(equalTo: firstTextField.trailingAnchor).isActive = true
        heightConstraint = firstTableView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.isActive = true
        
        // Register
        autoCompleteComponent = AutoCompleteComponent(heightConstraint: heightConstraint, tableView: firstTableView)
        autoCompleteComponent.datas = datas
    }
}
