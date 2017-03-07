//
//  Level3VC.swift
//  24 buttons
//
//  Created by Dmytro Ryshchuk on 01.03.17.
//  Copyright © 2017 Dmytro Ryshchuk. All rights reserved.
//

import UIKit

class Level3VC: UIViewController, MainProtocol, SecondLevelProtocol {
    
//    var mainLevelLogic = Level1VC()
    
    //MARK: - Outlets + Properties
    @IBOutlet weak var labelShowTime: UILabel!
    @IBOutlet weak var lastRecordTime: UILabel!
    @IBOutlet var buttonCollection: [UIButton]!
    
    var setOfNumbers = Set<Int>()
    var arrayOfNumbers = [Int]()
    var pressButtonValue = 0
//    var numberOfButtonsWerePressed = 0
//    var arrayOfTags = [Int]()
    
    var timer: Timer!
    var timerForLevel2: Timer!
    var timerCount = 50.0
    var timeForCurrentLevel = 50.0
    var callTimerAtFirstTime = true
    let defaults = UserDefaults.standard
    var setLastRecordTime = 0.0
    
    var alphaValue = 4.0
    
    //MARK: - Internal
    internal var labelShowTimeProtocol: UILabel!
    internal var buttonCollectionProtocol: [UIButton] = []
    
    
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
        buttonCollectionProtocol = buttonCollection
        labelShowTimeProtocol = labelShowTime
        passNumberInButtons(arrayOfButton: buttonCollection)
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
        fillSetWithValues()
        passNumberInButtons(arrayOfButton: buttonCollection)
        
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
//            numberOfButtonsWerePressed = pressButtonValue
//            print(numberOfButtonsWerePressed)
//            arrayOfNumbers.sort()
//            arrayOfNumbers.remove(at: 0)
//            print("array2 - \(arrayOfNumbers)")
//            arrayOfTags.append(sender.tag)
            

            arrayOfNumbers.shuffle()
            print("array3 - \(arrayOfNumbers)")
            print()
            let array = arrayOfNumbers
            for i in 0...array.count - 1 {
                buttonCollection[i].setTitle(String(array[i]), for: .normal)
            }
            
            pressButtonValue += 1
            //sender.isEnabled = false
            
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
    
    
    func fillSetWithValues() {
        repeat{
            let random = arc4random_uniform(26)
            if Int(random) != 0 {
                setOfNumbers.insert(Int(random))
            }
        } while setOfNumbers.count != 25
        
        makeNumbersInArrayInRandomPossition()
    }
    
    func makeNumbersInArrayInRandomPossition() {
        arrayOfNumbers.removeAll()
        for i in setOfNumbers {
            arrayOfNumbers.append(i)
        }
    }
    
    func passNumberInButtons(arrayOfButton: [UIButton]) {
        arrayOfNumbers.shuffle()
        
        let array = arrayOfNumbers
        for i in 0...array.count - 1 {
            arrayOfButton[i].setTitle(String(array[i]), for: .normal)
        }
    }
}
