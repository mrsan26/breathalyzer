//
//  ResultController.swift
//  breathalyzer
//
//  Created by Sanchez on 19.07.2023.
//

import UIKit

class ResultController: BasicPushController {

    static let id = String(describing: ResultController.self)
    
    @IBOutlet weak var alkoInBloodLabel: UILabel!
    @IBOutlet weak var alkoInBreathLabel: UILabel!
    @IBOutlet weak var alkoOutTimeLabel: UILabel!
    @IBOutlet weak var alkoClearDateLabel: UILabel!
    @IBOutlet weak var alkoClearDateMainView: LoginView!
    @IBOutlet weak var alkoStatusLabel: UILabel!
    @IBOutlet weak var alkoBehaviorLabel: UILabel!
    @IBOutlet weak var alkoDisfunctionLabel: UILabel!
    
    var results: ResultsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = results?.profileName, results?.profileName != "Некто" {
            title = "Результаты для \(name)"
        } else {
            title = "Результаты"
        }
        
        updateLabels()
    }

    func setResult(_ results: ResultsModel) {
        self.results = results
    }
    
    private func updateLabels() {
        guard let results else { return }
        alkoInBloodLabel.text = "\(results.alkoInBlood.checkMinus()) ‰"
        alkoInBreathLabel.text = "\(results.alkoInBreath.checkMinus()) мг/л"
        alkoOutTimeLabel.text = "\(results.removeTimeHours.checkMinus()) ч \(results.removeTimeMinutes.checkMinus()) мин"
        
        // Создаем объект DateFormatter для форматирования даты и времени
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy в HH:mm"

        // Преобразуем дату в строку в нужном формате
        let formattedDate = dateFormatter.string(from: results.dateSobriety)
        
        alkoClearDateLabel.text = formattedDate
        alkoClearDateMainView.isHidden = results.alkoInBlood <= 0
        
        switch results.alkoInBlood {
        case ...0:
            alkoStatusLabel.text = "☕️ Отсутствие влияния алкоголя ☕️"
        case 0.001..<0.35:
            alkoStatusLabel.text = "✅ Минимальное влияния алкоголя ✅"
        case 0.35..<0.5:
            alkoStatusLabel.text = "❕ Незначительное влияние алкоголя ❕"
        case 0.5..<1.5:
            alkoStatusLabel.text = "⚠️ Лёгкая степень опьянения ⚠️"
        case 1.5..<2.0:
            alkoStatusLabel.text = "❗️ Средняя степень опьянения ❗️"
        case 2.0..<3.0:
            alkoStatusLabel.text = "‼️ Сильная степень опьянения ‼️"
        case 3.0..<5.0:
            alkoStatusLabel.text = "❌ Тяжёлое алкогольное отравление ❌"
        case 5.0...:
            alkoStatusLabel.text = "🚨🚑☠️ Смертельное алкогольное отравление ☠️🚑🚨"
        default:
            break
        }
        
        switch results.alkoInBlood {
        case ..<0.2:
            alkoBehaviorLabel.text = AlkoEffects.null.behavior
            alkoDisfunctionLabel.text = AlkoEffects.null.disfunction
        case 0.2..<0.3:
            alkoBehaviorLabel.text = AlkoEffects.first.behavior
            alkoDisfunctionLabel.text = AlkoEffects.first.disfunction
        case 0.3..<0.6:
            alkoBehaviorLabel.text = AlkoEffects.second.behavior
            alkoDisfunctionLabel.text = AlkoEffects.second.disfunction
        case 0.6..<1:
            alkoBehaviorLabel.text = AlkoEffects.third.behavior
            alkoDisfunctionLabel.text = AlkoEffects.third.disfunction
        case 1..<2:
            alkoBehaviorLabel.text = AlkoEffects.fourth.behavior
            alkoDisfunctionLabel.text = AlkoEffects.fourth.disfunction
        case 2..<3:
            alkoBehaviorLabel.text = AlkoEffects.fifth.behavior
            alkoDisfunctionLabel.text = AlkoEffects.fifth.disfunction
        case 3..<4:
            alkoBehaviorLabel.text = AlkoEffects.six.behavior
            alkoDisfunctionLabel.text = AlkoEffects.six.disfunction
        case 4..<5:
            alkoBehaviorLabel.text = AlkoEffects.seven.behavior
            alkoDisfunctionLabel.text = AlkoEffects.seven.disfunction
        case 5...:
            alkoBehaviorLabel.text = AlkoEffects.eight.behavior
            alkoDisfunctionLabel.text = AlkoEffects.eight.disfunction
        default:
            break
        }
    }
    
    @IBAction func setNotificationAction(_ sender: Any) {        
        guard let results else { return }
        let localPush = LocalPush(
            title: "Вы протрезвели 😊",
            subtitle: "Прошло \(results.removeTimeHours) ч \(results.removeTimeMinutes) мин ⌚️",
            date: results.dateSobriety,
            repeats: false
        )
        
        PushManager().createPushFrom(push: localPush)
        showQuickNote(text: "Напоминание\nсоздано!")
    }
}
