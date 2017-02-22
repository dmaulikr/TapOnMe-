//
//  ViewController.swift
//  24 buttons
//
//  Created by Dmytro Ryshchuk on 21.02.17.
//  Copyright © 2017 Dmytro Ryshchuk. All rights reserved.
//

import UIKit

class SixteenNumbers: UIViewController {
    
    //MARK: - Outlets + Properties
    @IBOutlet weak var labelShowTime: UILabel!
    @IBOutlet weak var lastRecordTime: UILabel!
    @IBOutlet var buttonCollection: [UIButton]!
    
    var setOfNumbers = Set<Int>()
    var arrayOfNumbers = [Int]()
    var pressButtonValue = 1
    
    var timer: Timer!
    var timerCount = 0.0
    var callTimerAtFirstTime = true
    let defaults = UserDefaults.standard
    var setLastRecordTime = 0.0
    
    //MARK: - Default func
    override func viewWillAppear(_ animated: Bool) {
        fillSetWithValues()
        labelShowTime.isHidden = true
        
        if defaults.object(forKey: "time") == nil {
            lastRecordTime.isHidden = true
        } else {
            lastRecordTime.isHidden = false
            lastRecordTime.text = "Last Record: \(String(describing: defaults.object(forKey: "time")!)) sec"
            
            var checkLastTime = lastRecordTime.text!
            var index = checkLastTime.index(checkLastTime.startIndex, offsetBy: 13)
            checkLastTime = checkLastTime.substring(from: index)
            index = checkLastTime.index(checkLastTime.startIndex, offsetBy: 5)
            checkLastTime = checkLastTime.substring(to: index)
            
            if let checkLastTimeExist = Double(checkLastTime) {
                setLastRecordTime = checkLastTimeExist
            }
        }
        
        passNumberInButtons(arrayOfButton: buttonCollection)
    }
    
    //MARK: - Funcs
    func runTimeCode() {
        timerCount += 0.01
        labelShowTime.text = "Time: \(String(format: "%.3f", timerCount)) sec"
    }
    
    func alertControllerInfo(title: String, message:String) {
        let alertController = UIAlertController(title: title, message: "Your time: \(String(format: "%.3f", timerCount)) second.\n" +
            "\(message)", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            self.setOfNumbers.removeAll()
            self.dismiss(animated: true, completion: nil)
        }
        
        timer.invalidate()
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    //MARK: - Actions
    @IBAction func pressButtonAction(_ sender: UIButton) {
        if callTimerAtFirstTime {
            labelShowTime.isHidden = false
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(SixteenNumbers.runTimeCode), userInfo: nil, repeats: true)
            callTimerAtFirstTime = false
        }
        if sender.titleLabel?.text == String(pressButtonValue) {
            pressButtonValue += 1
            sender.isEnabled = false
            if pressButtonValue == 17 {
                alertControllerInfo(title:"Congratulate!", message:"You made this!")
                
                if defaults.object(forKey: "time") != nil {
                    if Double(String(format: "%.3f", timerCount))! < setLastRecordTime {
                        defaults.set(String(format: "%.3f", timerCount), forKey: "time")
                    }
                } else {
                    defaults.set(String(format: "%.3f", timerCount), forKey: "time")
                }
            }
        } else {
            alertControllerInfo(title:"Error", message:"You tap a wrong number!")
        }
    }
}
