//
//  Extensions.swift
//  24 buttons
//
//  Created by Dmytro Ryshchuk on 22.02.17.
//  Copyright © 2017 Dmytro Ryshchuk. All rights reserved.
//

import UIKit

//MARK: - Protocols
protocol MainProtocol: class {
    var labelShowTimeProtocol: UILabel! {
        get set
    }
    var timerCount: Double {
        get set
    }
    var setOfNumbers: Set<Int> {
        get set
    }
    var timeForCurrentLevel: Double {
        get set
    }
    var pressButtonValue: Int {
        get set
    }
    var buttonCollectionProtocol: [UIButton] {
        get set
    }
    
    func alertControllerInfo(title: String, message:String, timeForCurrentLevel: Double, fromController controller: UIViewController)
}

protocol SecondLevelProtocol: class {
    var alphaValue: Double {
        get set
    }
    var buttonCollectionProtocol: [UIButton] {
        get set
    }
    
    func runTimeCode()
}

//MARK: - Extensions
extension Level1VC {
    /* Fill buttons with random number */
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
        
        arrayOfNumbers.shuffle()
    }
    
    func passNumberInButtons(arrayOfButton: [UIButton]) {
        let array = arrayOfNumbers
        for i in 0...24 {
            arrayOfButton[i].setTitle(String(array[i]), for: .normal)
        }
    }
}

extension Array {
    /* Randomizes the order of an array's elements. */
    mutating func shuffle() {
        for _ in 0..<10 {
            sort { (_,_) in arc4random() < arc4random()
            }
        }
    }
}

extension MainProtocol {
    func runTimeCode() {
        timerCount -= 0.01
        labelShowTimeProtocol.text = "Time: \(String(format: "%.3f", timerCount)) sec"
        
        if timerCount < 0.0 {
            alertControllerInfo(title:"Time out!", message:"I belive in you! Try one more time.", timeForCurrentLevel: timeForCurrentLevel, fromController: self as! UIViewController)
        }
    }
    
    func alertControllerInfo(title: String, message:String, timeForCurrentLevel: Double, fromController controller: UIViewController) {
        print("\(title) \(message) - protocol")
        var alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if title == "Time out!" || title == "Wrong!" {
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        } else {
            alertController = UIAlertController(title: title, message: "Your time: \(timeForCurrentLevel - (Double(String(format: "%.3f", timerCount)))!) second.\n" +
                "\(message)", preferredStyle: .alert)
        }
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            self.setOfNumbers.removeAll()
        }
        
        alertController.addAction(OKAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}

extension SecondLevelProtocol {
    func level2_TheMoreTimeGoneTheLessAlphaIs(alpha: Double) {
        alphaValue = alpha
        alphaValue -= 0.007
        for i in 0...24 {
            buttonCollectionProtocol[i].alpha = CGFloat(alphaValue)
        }
        if alphaValue < 0.25 {
            alphaValue = 0.25
        }
    }
    
    func makeButtonEnableAgain() {
        for i in 0...24 {
            buttonCollectionProtocol[i].isEnabled = true
        }
    }
}

