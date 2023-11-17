//
//  HistoryController.swift
//  breathalyzer
//
//  Created by Sanchez on 26.07.2023.
//

import UIKit

class HistoryController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var emptynessLabel: UILabel!
    
    var historyInfo: [ResultsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "История"
        updateHistoryInfo()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUI()
        updateHistoryInfo()
        historyTableView.reloadData()
    }
    
    private func setupUI() {
        let clearButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(clearAction))
        navigationItem.rightBarButtonItem = clearButton
    }
    
    private func setupTableView() {
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
        let nib = UINib(nibName: HistoryCell.id, bundle: nil)
        historyTableView.register(nib, forCellReuseIdentifier: HistoryCell.id)
    }
    
    private func updateHistoryInfo() {
        historyInfo = RealmManager<ResultsModel>().read()
        historyInfo = historyInfo.sorted(by: {$0.dateOfCounting > $1.dateOfCounting})
        emptynessLabel.isHidden = !historyInfo.isEmpty
    }
    
}

extension HistoryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: HistoryCell.id, for: indexPath)
        guard let historyCell = cell as? HistoryCell else { return UITableViewCell() }
        
        historyCell.set(results: historyInfo[indexPath.row])
        
        return historyCell
    }
    
    private func showInputDialog(title: String, message: String?, completion: @escaping () -> Void) {
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
    
    @objc func clearAction() {
        showInputDialog(title: "Очистить историю?", message: nil) {
            RealmManager().deleteObjects(objects: self.historyInfo)
            self.updateHistoryInfo()
            self.historyTableView.reloadData()
        }
    }
}

extension HistoryController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let resultVC = ResultController(nibName: ResultController.id, bundle: nil)
        let resultVCnav = UINavigationController(rootViewController: resultVC)
        resultVC.setResult(historyInfo[indexPath.row])
        present(resultVCnav, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            RealmManager().delete(object: historyInfo[indexPath.row])
            updateHistoryInfo()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
