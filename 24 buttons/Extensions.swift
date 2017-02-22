//
//  Extensions.swift
//  24 buttons
//
//  Created by Dmytro Ryshchuk on 22.02.17.
//  Copyright © 2017 Dmytro Ryshchuk. All rights reserved.
//

import UIKit

//MARK: - Extensions
extension SixteenNumbers {
    /* Fill buttons with random number */
    func fillSetWithValues() {
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
    
    func passNumberInButtons(arrayOfButton: [UIButton]) {
        let array = arrayOfNumbers
        for i in 0...15 {
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
