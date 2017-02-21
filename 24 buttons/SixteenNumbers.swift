//
//  ViewController.swift
//  24 buttons
//
//  Created by Dmytro Ryshchuk on 21.02.17.
//  Copyright © 2017 Dmytro Ryshchuk. All rights reserved.
//

import UIKit

class SixteenNumbers: UIViewController {
    
    @IBOutlet weak var labelShowTime: UILabel!
    @IBOutlet weak var lastRecordTime: UILabel!
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    
    var setOfNumbers = Set<Int>()
    var arrayOfNumbers = [Int]()
    var pressButtonValue = 1
    var fillAllButtonsWithNumber = 1
    
    var timer: Timer!
    var timerCount = 0.0
    var callTimerAtFirstTime = true
    let defaults = UserDefaults.standard

    
    override func viewWillAppear(_ animated: Bool) {
        
        makeRandomValue()
        labelShowTime.isHidden = true
        
        if defaults.object(forKey: "time") == nil {
            lastRecordTime.isHidden = true
        } else {
            lastRecordTime.isHidden = false
            lastRecordTime.text = "Last Record: \(String(describing: defaults.object(forKey: "time")!)) sec"
        }
        
        passNumberInButton(arrayOfButton: buttonCollection)
    }
    
    func runTimeCode() {
        timerCount += 0.01
        labelShowTime.text = "Time: \(String(format: "%.3f", timerCount)) sec"
    }
    
    func passNumberInButton(arrayOfButton: [UIButton]) {
        let array = arrayOfNumbers
        for i in 0...15 {
            arrayOfButton[i].setTitle(String(array[i]), for: .normal)
        }
    }

    func makeRandomValue() {
        repeat{
            let random = arc4random_uniform(17)
            if Int(random) != 0 {
                setOfNumbers.insert(Int(random))
            }
        } while setOfNumbers.count != 16
    
        makeNumbersInArrayInRandomPossition()
    }
    
    func makeNumbersInArrayInRandomPossition() {
        for i in setOfNumbers {
            arrayOfNumbers.append(i)
        }
        arrayOfNumbers.shuffle()
    }
    
    func alertControllerInfo(title: String, message:String) {
        print("time: \(timerCount)")
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
                defaults.set(String(format: "%.3f", timerCount), forKey: "time")
                alertControllerInfo(title:"Congratulate!", message:"You made this!")
            }
        } else {
            alertControllerInfo(title:"Error", message:"You tap a wrong number!")
        }
    }

}

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
