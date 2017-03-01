//
//  Level2VC.swift
//  24 buttons
//
//  Created by Dmytro Ryshchuk on 01.03.17.
//  Copyright © 2017 Dmytro Ryshchuk. All rights reserved.
//

import UIKit

class Level2VC:  UIViewController, MainProtocol, SecondLevelProtocol {
    
    var sixteenNumbers = Level1VC()
    
    //MARK: - Outlets + Properties
    @IBOutlet weak var labelShowTime: UILabel!
    @IBOutlet weak var lastRecordTime: UILabel!
    @IBOutlet var buttonCollection: [UIButton]!
    
    var setOfNumbers = Set<Int>()
    var arrayOfNumbers = [Int]()
    var pressButtonValue = 0
    
    var timer: Timer!
    var timerForLevel2: Timer!
    var timerCount = 15.0
    var timeForCurrentLevel = 15.0
    var callTimerAtFirstTime = true
    let defaults = UserDefaults.standard
    var setLastRecordTime = 0.0
    
    var alphaValue = 1.0
    
    //MARK: - Internal
    internal var labelShowTimeProtocol: UILabel!
    internal var buttonCollectionProtocol: [UIButton] = []
    
    
    //MARK: - Default func
    override func viewWillAppear(_ animated: Bool) {
        sixteenNumbers.fillSetWithValues()
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
        buttonCollectionProtocol = buttonCollection
        labelShowTimeProtocol = labelShowTime
        sixteenNumbers.passNumberInButtons(arrayOfButton: buttonCollection)
    }
    
    //MARK: - Funcs
    func alertControllerInfoProtocol(titleP: String, messageP: String) {
        alertControllerInfo(title: titleP, message: messageP, timeForCurrentLevel: self.timeForCurrentLevel, fromController: self)
        print("\(titleP) \(messageP) - main")
        timer.invalidate()
        timerForLevel2.invalidate()
    }
    
    func mainTimerFuncRun() {
        if timerCount > 0.0 {
            runTimeCode()
        } else {
            restartButtonAction(Any.self)
        }
    }
    func secondLevelFuncRun() {
        level2_TheMoreTimeGoneTheLessAlphaIs(alpha: alphaValue)
    }
    
    
    @IBAction func restartButtonAction(_ sender: Any) {
        timer.invalidate()
        timerForLevel2.invalidate()
        
        pressButtonValue = 0
        timerCount = timeForCurrentLevel
        level2_TheMoreTimeGoneTheLessAlphaIs(alpha: 1.0)    //TODO: check if it implemented
        labelShowTime.text = ""
        
        makeButtonEnableAgain()
        sixteenNumbers.fillSetWithValues()
        sixteenNumbers.passNumberInButtons(arrayOfButton: buttonCollection)
        
        callTimerAtFirstTime = true
    }
    
    //MARK: - Actions
    @IBAction func pressButtonAction(_ sender: UIButton) {
        if callTimerAtFirstTime {
            labelShowTime.isHidden = false
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(mainTimerFuncRun), userInfo: nil, repeats: true)
            timerForLevel2 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(secondLevelFuncRun), userInfo: nil, repeats: true)
            
            callTimerAtFirstTime = false
        }
        if sender.titleLabel?.text == String(pressButtonValue + 1) {
            pressButtonValue += 1
            sender.isEnabled = false
            if pressButtonValue == 25 {
                alertControllerInfoProtocol(titleP:"Congratulate!", messageP:"You made this!")
                
                if defaults.object(forKey: "time") != nil {
                    if timeForCurrentLevel - (Double(String(format: "%.3f", timerCount)))! < setLastRecordTime {
                        defaults.set(timeForCurrentLevel - (Double(String(format: "%.3f", timerCount)))!, forKey: "time")
                    }
                } else {
                    defaults.set(timeForCurrentLevel - (Double(String(format: "%.3f", timerCount)))!, forKey: "time")
                }
                restartButtonAction(Any.self)
            }
        } else {
            alertControllerInfoProtocol(titleP:"Wrong!", messageP:"You tap a wrong number!")
            restartButtonAction(Any.self)
        }
    }
}
