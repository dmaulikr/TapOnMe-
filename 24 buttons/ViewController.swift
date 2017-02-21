//
//  ViewController.swift
//  24 buttons
//
//  Created by Dmytro Ryshchuk on 21.02.17.
//  Copyright © 2017 Dmytro Ryshchuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    var myValue = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeRandomValue()
    }

    func makeRandomValue() {
        repeat{
            let random = arc4random_uniform(17)
            if Int(random) != 0 {
                setOfNumbers.insert(Int(random))
            }
            print(random)
        } while setOfNumbers.count != 16
    
        setRandomValueToButton()
    }
    
    func setRandomValueToButton() {
        print("\n\n\n")
        var x = 1
        for s in setOfNumbers {
            if x == 1 {
                button1.setTitle(String(s), for: .normal)
                x += 1
            } else if x == 2 {
                button2.setTitle(String(s), for: .normal)
                x += 1
            } else if x == 3  {
                button3.setTitle(String(s), for: .normal)
                x += 1
            } else if x == 4 {
                button4.setTitle(String(s), for: .normal)
                x += 1
            } else if x == 5 {
                button5.setTitle(String(s), for: .normal)
                x += 1
            } else if x == 6 {
                button6.setTitle(String(s), for: .normal)
                x += 1
            } else if x == 7 {
                button7.setTitle(String(s), for: .normal)
                x += 1
            } else if x == 8 {
                button8.setTitle(String(s), for: .normal)
                x += 1
            } else if x == 9 {
                button9.setTitle(String(s), for: .normal)
                x += 1
            } else if x == 10 {
                button10.setTitle(String(s), for: .normal)
                x += 1
            } else if x == 11 {
                button11.setTitle(String(s), for: .normal)
                x += 1
            } else if x == 12 {
                button12.setTitle(String(s), for: .normal)
                x += 1
            } else if x == 13 {
                button13.setTitle(String(s), for: .normal)
                x += 1
            } else if x == 14 {
                button14.setTitle(String(s), for: .normal)
                x += 1
            } else if x == 15 {
                button15.setTitle(String(s), for: .normal)
                x += 1
            } else {
                button16.setTitle(String(s), for: .normal)
                x += 1
            }
        }
    }
    
    
    @IBAction func pressButtonAction(_ sender: UIButton) {
        
        if sender.titleLabel?.text == String(myValue) {
            print("Sucses")
            myValue += 1
            sender.isEnabled = false
            print("myValue = \(myValue)")
        } else {
            print("Error")
        }
    }

}

