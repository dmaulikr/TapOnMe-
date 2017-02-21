//
//  ViewController.swift
//  24 buttons
//
//  Created by Dmytro Ryshchuk on 21.02.17.
//  Copyright © 2017 Dmytro Ryshchuk. All rights reserved.
//

import UIKit

class SixteenNumbers: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button14: UIButton!
    @IBOutlet weak var button15: UIButton!
    @IBOutlet weak var button16: UIButton!
    
    
    var setOfNumbers = Set<Int>()
    var arrayOfNumbers = [Int]()
    var pressButtonValue = 1
    var fillAllButtonsWithNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        makeRandomValue()
    }

    func makeRandomValue() {
        repeat{
            let random = arc4random_uniform(17)
            if Int(random) != 0 {
                setOfNumbers.insert(Int(random))
            }
        } while setOfNumbers.count != 16
    
        randF()
    }
    
    func randF() {
        for i in setOfNumbers {
            arrayOfNumbers.append(i)
        }
        arrayOfNumbers.shuffle()
        
        setRandomValueToButton()
    }
    
    func setRandomValueToButton() {
        for numberFromSet in arrayOfNumbers {
            if fillAllButtonsWithNumber == 1 {
                button1.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            } else if fillAllButtonsWithNumber == 2 {
                button2.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            } else if fillAllButtonsWithNumber == 3  {
                button3.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            } else if fillAllButtonsWithNumber == 4 {
                button4.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            } else if fillAllButtonsWithNumber == 5 {
                button5.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            } else if fillAllButtonsWithNumber == 6 {
                button6.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            } else if fillAllButtonsWithNumber == 7 {
                button7.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            } else if fillAllButtonsWithNumber == 8 {
                button8.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            } else if fillAllButtonsWithNumber == 9 {
                button9.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            } else if fillAllButtonsWithNumber == 10 {
                button10.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            } else if fillAllButtonsWithNumber == 11 {
                button11.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            } else if fillAllButtonsWithNumber == 12 {
                button12.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            } else if fillAllButtonsWithNumber == 13 {
                button13.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            } else if fillAllButtonsWithNumber == 14 {
                button14.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            } else if fillAllButtonsWithNumber == 15 {
                button15.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            } else {
                button16.setTitle(String(numberFromSet), for: .normal)
                fillAllButtonsWithNumber += 1
            }
        }
    }
   
    
    @IBAction func pressButtonAction(_ sender: UIButton) {
        if sender.titleLabel?.text == String(pressButtonValue) {
            pressButtonValue += 1
            sender.isEnabled = false
        } else {
            let alertController = UIAlertController(title: "Error", message: "You tap wrong number", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                self.setOfNumbers.removeAll()
                self.dismiss(animated: true, completion: nil)
            }
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
            
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