//
//  BasePushController.swift
//  breathalyzer
//
//  Created by Sanchez on 26.07.2023.
//

import UIKit

class BasicPushController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    private func makeUI() {
        let doneButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(exitAction))
        navigationItem.leftBarButtonItem = doneButton
    }
    
    @objc func exitAction() {
        dismiss(animated: true, completion: nil)
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
    
    func showQuickNote(text: String) {
        let animatedView = UIView(frame: CGRect(x: -150, y: self.view.bounds.height / 2 - 60, width: 150, height: 60))
        
        animatedView.backgroundColor = UIColor.white
        animatedView.layer.cornerRadius = 8
        animatedView.clipsToBounds = true
        
        animatedView.layer.masksToBounds = false
        animatedView.layer.shadowColor = UIColor.gray.cgColor
        animatedView.layer.shadowOpacity = 0.3
        animatedView.layer.shadowOffset = CGSize(width: 3, height: 3)
        animatedView.layer.shadowRadius = 3.0
        
        view.addSubview(animatedView)
        
        // Создаем UILabel
        let label = UILabel()
        label.text = text
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2

        // Добавляем лейбл внутрь UIView
        animatedView.addSubview(label)

        // Центрируем лейбл внутри UIView
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: animatedView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: animatedView.centerYAnchor).isActive = true
        
        // Выполняем анимацию
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
            // Начальное состояние - вне экрана слева
            animatedView.transform = CGAffineTransform(translationX: self.view.bounds.width / 2 + animatedView.bounds.width / 2, y: 0)
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
                    // Начальное состояние - вне экрана слева
                    animatedView.transform = CGAffineTransform(translationX: self.view.bounds.width + animatedView.bounds.width + 1, y: 0)
                }) { _ in
                    animatedView.removeFromSuperview()
                }
            }
        }
    }
}
