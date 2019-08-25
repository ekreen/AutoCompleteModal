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
    @IBOutlet weak var secondTextField: UITextField!
    
    // MARK: - Properties
    private var firstAutoCompleteComponent: AutoCompleteComponent!
    private var secondAutoCompleteComponent: AutoCompleteComponent!
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
        setupAutoCompletionComponent()
        setupTextField()
        setupModal()
    }
    
    func setupModal() {
        modalView.layer.cornerRadius = 15
    }
    
    func setupTextField() {
        firstTextField.delegate = firstAutoCompleteComponent
        secondTextField.delegate = secondAutoCompleteComponent
    }
    
    func setupAutoCompletionComponent() {
        firstAutoCompleteComponent = prepareAutoCompletionComponent(for: firstTextField)
        secondAutoCompleteComponent = prepareAutoCompletionComponent(for: secondTextField)
    }
}

private extension ModalViewController {
    func prepareAutoCompletionComponent(for textField: UITextField) -> AutoCompleteComponent {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.isHidden = true
        
        // Constraints
        tableView.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
        let heightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.isActive = true
        
        // Register
        let autoCompleteComponent = AutoCompleteComponent(heightConstraint: heightConstraint, tableView: tableView)
        autoCompleteComponent.datas = datas
        
        return autoCompleteComponent
    }
}
