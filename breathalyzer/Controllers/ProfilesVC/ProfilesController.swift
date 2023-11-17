//
//  ProfilesController.swift
//  breathalyzer
//
//  Created by Sanchez on 24.07.2023.
//

import UIKit

class ProfilesController: BasicPushController {

    static let id = String(describing: ProfilesController.self)
    
    @IBOutlet weak var profilesTableView: UITableView!
    @IBOutlet weak var emptynessLabel: UILabel!
    
    var profiles: [UserProfile] = []
    var updateLoginControllerClosure: ((UserProfile) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Сохраненные профили"
        setupUI()
        updateInfo()
        setupTableView()
    }
    
    private func setupUI() {
        let clearButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(clearAction))
        navigationItem.rightBarButtonItem = clearButton
    }

    private func setupTableView() {
        profilesTableView.dataSource = self
        profilesTableView.delegate = self
        let nib = UINib(nibName: ProfileCell.id, bundle: nil)
        profilesTableView.register(nib, forCellReuseIdentifier: ProfileCell.id)
    }
    
    private func updateInfo() {
        profiles = RealmManager<UserProfile>().read()
        emptynessLabel.isHidden = !profiles.isEmpty
    }
    
    @objc func clearAction() {
        showInputDialog(title: "Удалить все профили?", message: nil) {
            RealmManager().deleteObjects(objects: self.profiles)
            self.updateInfo()
            self.profilesTableView.reloadData()
        }
    }
    
}

extension ProfilesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profilesTableView.dequeueReusableCell(withIdentifier: ProfileCell.id, for: indexPath)
        guard let profileCell = cell as? ProfileCell else { return UITableViewCell() }

        profileCell.set(profile: profiles[indexPath.row])
        
        return profileCell
    }
}

extension ProfilesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        updateLoginControllerClosure?(profiles[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            RealmManager().delete(object: profiles[indexPath.row])
            updateInfo()
            
            // Удаляется соответствующая ячейка из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
