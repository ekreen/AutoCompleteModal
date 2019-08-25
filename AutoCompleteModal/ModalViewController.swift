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
    private var firstDelegate: AutoCompleteDelegate!
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
        firstTextField.delegate = self
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
        firstDelegate = AutoCompleteDelegate(heightConstraint: heightConstraint)
        firstTableView.delegate = firstDelegate
        firstTableView.dataSource = firstDelegate
        firstTableView.register(UITableViewCell.self, forCellReuseIdentifier: "identifierCell")
        firstTableView.reloadData()
        firstDelegate.updateHeight(firstTableView)
    }
    
    func reloadTableView() {
        firstTableView.reloadData()
        firstDelegate.updateHeight(firstTableView)
    }
}

extension ModalViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        firstTableView.isHidden = true
        
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
        
        firstDelegate.autoCompleteDatas = datas.filter {
            $0.uppercased().contains(text.uppercased())
        }
        
        reloadTableView()
        firstTableView.isHidden = false
        return true
    }
}
