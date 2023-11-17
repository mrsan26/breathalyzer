//
//  LoginController.swift
//  breathalyzer
//
//  Created by Sanchez on 16.07.2023.
//

import UIKit
import RealmSwift

class LoginController: BasicPushVC {
    
    @IBOutlet weak var weightTextField: TextFieldCustom!
    @IBOutlet weak var heightTextField: TextFieldCustom!
    @IBOutlet weak var sexSegment: UISegmentedControl!
    
    @IBOutlet weak var amountTextField: TextFieldCustom!
    @IBOutlet weak var degreeTextField: TextFieldCustom!
    
    @IBOutlet weak var hungrySegment: UISegmentedControl!
    
    @IBOutlet weak var whatTimePicker: UIPickerView!
    private let whatTimePickerData: [String] = ["Сразу же", "1 час", "2 часа", "3 часа", "4 часа", "5 часов", "6 часов", "7 часов", "8 часов", "9 часов", "10 часов", "11 часов", "12 часов"]
    
    @IBOutlet weak var whenTimePicker: UIPickerView!
    private let whenTimePickerData: [String] = ["Меньше часа", "1 час", "2 часа", "3 часа", "4 часа", "5 часов", "6 часов", "7 часов", "8 часов", "9 часов", "10 часов", "11 часов", "12 часов"]
    
    @IBOutlet weak var saveNewProfileSwitcher: UISwitch!
    
    @IBOutlet weak var mainAlkoCollectionView: LoginView!
    @IBOutlet weak var alkoCollectionView: UICollectionView!
    
    private var weight: Double = 0
    private var heigh: Double = 0
     
    private var sex: Double = 0
    private var sexAbsorption: Double = 0
    private var hungry: Double = 0
    
    private var amount: Double = 0
    private var degree: Double = 0
    
    private var whatTimeDrinking: Double = 0
    private var whenTimeDrinking: Double = 0
    
    private var selectedProfileName: String?
    private var alkoDrinksArray: [AlkoDrinkModel] = []
    
    private var manyAlkoDrinks: Bool {
        !alkoDrinksArray.isEmpty
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Данные"
        setupUI()
        hideKeyboardWhenTappedAround()
    }
    
    private func setupUI() {
        whatTimePicker.dataSource = self
        whatTimePicker.delegate = self
        whenTimePicker.dataSource = self
        whenTimePicker.delegate = self
        
        alkoCollectionView.dataSource = self
        alkoCollectionView.delegate = self
        mainAlkoCollectionView.isHidden = true
        
        let nib = UINib(nibName: AlcoDrinkCell.id, bundle: nil)
        alkoCollectionView.register(nib, forCellWithReuseIdentifier: AlcoDrinkCell.id)
        
        let clearButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(clearAction))
        navigationItem.rightBarButtonItem = clearButton
    }
    
    
    private func checkCorrect(roolsFor: TextFieldRools, info: Int) -> Bool {
        if info >= roolsFor.from, info <= roolsFor.to {
            return true
        } else {
            return false
        }
    }
    
    private func checkUserInfo() -> Bool {
        var userInfoStatusIsCorrect: Bool = true
        let textFieldArray: [TextFieldCustom] = [weightTextField, heightTextField, amountTextField, degreeTextField]
        let roolsForTextFields: [TextFieldRools] = [.weight, .height, .amount, .degree]
        
        for (index, textField) in textFieldArray.enumerated() {
            let roolFor: TextFieldRools = roolsForTextFields[index]
            
            if !checkCorrect(roolsFor: roolFor, info: textField.text.toInt()), textField.needToCheckup {
                textField.text = ""
                textField.placeholder = roolFor.correctInfo
                textField.shakeAnimation()
                userInfoStatusIsCorrect = false
            } else {
                textField.placeholder = roolFor.defaultPlaceholder
            }
        }
        
        if userInfoStatusIsCorrect {
            weight = weightTextField.text.toDouble()
            amount = amountTextField.text.toDouble()
            degree = degreeTextField.text.toDouble()
            
            switch heightTextField.text.toDouble() {
            case 120...139 :
                heigh = 1
            case 140...159 :
                heigh = 0.9
            case 160...179 :
                heigh = 0.8
            case 180... :
                heigh = 0.75
            default:
                break
            }
            
            switch sexSegment.selectedSegmentIndex {
            case 0:
                sex = 0.7
                sexAbsorption = 0.1
            case 1:
                sex = 0.6
                sexAbsorption = 0.085
            default:
                break
            }
            
            switch hungrySegment.selectedSegmentIndex {
            case 0:
                hungry = 0.1
            case 1:
                hungry = 0.2
            case 2:
                hungry = 0.3
            default:
                break
            }
        }
        return userInfoStatusIsCorrect
    }
    
    private func promiliCalculating() -> Double {
        let resultPromili = (((degree / 100) * (amount - amount * hungry) * heigh) / (sex * weight) - ((whatTimeDrinking + whenTimeDrinking) * sexAbsorption)).roundForSignsAfterDot(2)
        return resultPromili
    }
    
    private func resultCounting() -> ResultsModel? {
        guard checkUserInfo() else { return nil }
        
        var resultPromili: Double = 0
        
        if !alkoDrinksArray.isEmpty {
            alkoDrinksArray.forEach { alkoDrinkModel in
                amount = alkoDrinkModel.amount.toDouble()
                degree = alkoDrinkModel.degree.toDouble()
                resultPromili += promiliCalculating()
            }
        } else {
            resultPromili = promiliCalculating()
        }
        
        let resultMgL = (resultPromili / 2.1875).roundForSignsAfterDot(2)
        
        let timeHoursOveral = (resultPromili / sexAbsorption).roundForSignsAfterDot(2)
        let minutes = timeHoursOveral.truncatingRemainder(dividingBy: 1.0) * 60
        let hours = timeHoursOveral - timeHoursOveral.truncatingRemainder(dividingBy: 1.0)
        
        // Получаем текущую дату и время
        let currentDate = Date()

        // Создаем объект Calendar для работы с датой и временем
        let calendar = Calendar.current

        guard let updatedDate = calendar.date(byAdding: .hour, value: hours.toInt(), to: currentDate) else { return nil }
        guard let updatedDateWithHalfHour = calendar.date(byAdding: .minute, value: minutes.toInt(), to: updatedDate) else { return nil }
        
        let results: ResultsModel = .init(
            profileName: selectedProfileName ?? "Некто",
            alkoInBlood: resultPromili.roundForSignsAfterDot(2),
            alkoInBreath: resultMgL,
            removeTimeHours: hours.toInt(),
            removeTimeMinutes: minutes.toInt(),
            dateSobriety: updatedDateWithHalfHour,
            dateOfCounting: Date()
        )
        
        return results
    }
    
    private func addNewProfile() {
        let allProfiles: [UserProfile] = RealmManager<UserProfile>().read()
        
        var uniqID: Int = 0
        repeat {
            uniqID += 1
        } while allProfiles.filter({$0.ID == uniqID}).count > 0
        
        
        let newProfile: UserProfile = .init(
            name: "",
            weight: weightTextField.text.toInt(),
            height: heightTextField.text.toInt(),
            sex: sexSegment.selectedSegmentIndex,
            ID: uniqID
        )
        
        showInputDialogTextField(title: "Имя нового профиля", message: nil, placeholder: "Введите имя") { userInput in
            guard let userInput, !userInput.isEmpty else { return }
            RealmManager().update { realm in
                try? realm.write({
                    newProfile.name = userInput
                })
            }
            
            self.selectedProfileName = newProfile.name
            self.title = "Данные для \(newProfile.name)"
            
            self.createResultsVC()
            RealmManager().write(newProfile)
            self.saveNewProfileSwitcher.isOn = false
        }
    }
    
    private func createResultsVC() {
        guard let results = resultCounting() else { return }
        let resultVC = ResultController(nibName: ResultController.id, bundle: nil)
        let resultVCnav = UINavigationController(rootViewController: resultVC)
        resultVC.setResult(results)
        present(resultVCnav, animated: true, completion: nil)
    }
    
    private func clearAlcoCollection() {
        alkoDrinksArray.removeAll()
        alkoCollectionView.reloadData()
        mainAlkoCollectionView.isHidden = true
    }
    
    @IBAction func countAction(_ sender: Any) {
        if !alkoDrinksArray.isEmpty {
            amountTextField.needToCheckup = false
            degreeTextField.needToCheckup = false
        }
        
        
        guard let results = resultCounting() else { return }
        
        RealmManager<ResultsModel>().write(results)
        
        if saveNewProfileSwitcher.isOn {
            addNewProfile()
        } else {
            createResultsVC()
        }
        
        
        if !alkoDrinksArray.isEmpty {
            amountTextField.needToCheckup = true
            degreeTextField.needToCheckup = true
        }
    }
    
    @IBAction func openProfilesAction(_ sender: Any) {
        let profilesVC = ProfilesController(nibName: ProfilesController.id, bundle: nil)
        
        let profilesVCnav = UINavigationController(rootViewController: profilesVC)
        profilesVC.updateLoginControllerClosure = { [weak self] profile in
            guard let self else { return }
            self.weightTextField.text = profile.weight.toString()
            self.heightTextField.text = profile.height.toString()
            self.sexSegment.selectedSegmentIndex = profile.sex
            self.selectedProfileName = profile.name
            self.title = "Данные для \(profile.name)"
        }
        
        present(profilesVCnav, animated: true, completion: nil)
    }
    
    @IBAction func addAlkoDrinkAction(_ sender: Any) {
        guard checkUserInfo() else { return }
        alkoDrinksArray.append(.init(amount: amountTextField.text.toInt(), degree: degreeTextField.text.toInt()))
        mainAlkoCollectionView.isHidden = false
        alkoCollectionView.insertItems(at: [IndexPath.init(row: alkoDrinksArray.count - 1, section: 0)])
        
        degreeTextField.text?.removeAll()
        amountTextField.text?.removeAll()
    }
    
    @IBAction func clearAlkoDrinkCollectionAction(_ sender: Any) {
        clearAlcoCollection()
    }
    
    
    
    @objc func clearAction() {
        title = "Данные"
        let textFieldArray: [UITextField] = [weightTextField, heightTextField, amountTextField, degreeTextField]
        textFieldArray.forEach { textField in
            textField.text?.removeAll()
        }
        sexSegment.selectedSegmentIndex = 0
        hungrySegment.selectedSegmentIndex = 0
        whatTimePicker.selectRow(0, inComponent: 0, animated: true)
        whenTimePicker.selectRow(0, inComponent: 0, animated: true)
        selectedProfileName = nil
        
        clearAlcoCollection()
    }
}

extension LoginController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        whatTimePickerData.count
    }
}

extension LoginController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        
        if pickerView == whatTimePicker {
            label.text = whatTimePickerData[row] // Задайте текст для отображения строки
        } else if pickerView == whenTimePicker {
            label.text = whenTimePickerData[row] // Задайте текст для отображения строки
        }
        
        label.textAlignment = .center
        label.font.withSize(16)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == whatTimePicker {
            whatTimeDrinking = row.toDouble()
        } else if pickerView == whenTimePicker {
            whenTimeDrinking = row.toDouble()
        }
    }
}

extension LoginController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alkoDrinksArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = alkoCollectionView.dequeueReusableCell(withReuseIdentifier: AlcoDrinkCell.id, for: indexPath)
        guard let alcoDrinkCel = cell as? AlcoDrinkCell else { return UICollectionViewCell() }
        
        alcoDrinkCel.set(alkoDrink: alkoDrinksArray[indexPath.row])
        
        return alcoDrinkCel
    }
}

extension LoginController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showInputDialog(title: "Удалить напиток?", message: nil) {
            self.alkoDrinksArray.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
            self.mainAlkoCollectionView.isHidden = self.alkoDrinksArray.isEmpty
        }
    }
}
