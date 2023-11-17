//
//  BasicPresentVC.swift
//  breathalyzer
//
//  Created by Sanchez on 31.07.2023.
//

import Foundation

import UIKit

class BasicPushVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    private func makeUI() {
    }

    func showInputDialogTextField(title: String, message: String?, placeholder: String, completion: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = placeholder
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            completion(nil)
        }
        
        let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
            guard let textField = alertController.textFields?.first,
                  let inputText = textField.text else {
                completion(nil)
                return
            }
            completion(inputText)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showInputDialog(title: String, message: String?, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
        }
        
        let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
            completion()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
