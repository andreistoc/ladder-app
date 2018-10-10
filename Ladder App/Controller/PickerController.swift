//
//  PickerController.swift
//  Ladder App
//
//  Created by Andrew Istoc on 19/09/2018.
//  Copyright © 2018 Andrew Istoc. All rights reserved.
//

import UIKit

class PickerController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //The number of the cell that was selected when customizing
    var customizeCellSelected = 0
    
    var ascendingDescending = ["Ascending", "Descending"]
    var wavingOrNot = ["Waving", "Simple"]
    var maximumNumberOfReps: [Int] = []
    var timePerRepetition: [Int] = []
    var restPerRepetition: [Int] = []
    var laddersToDo: [Int] = []
    var restBetweenLadders: [Int] = []
    
    //Array that stores the data used
    var arrayToUse: [String] = []
    var rowToSelect: Int = 0
    
    
    //Picker Outlet
    @IBOutlet weak var optionPicker: UIPickerView!
    @IBOutlet weak var titleTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        maximumNumberOfReps = Array(3...20)
        timePerRepetition = Array(2...10)
        restPerRepetition = Array(2...10)
        laddersToDo = Array(1...10)
        restBetweenLadders = Array(1...10)
        
        // Do any additional setup after loading the view.
        print(customizeCellSelected)
        choosePicker()
        
        optionPicker.dataSource = self
        optionPicker.delegate = self
        
        optionPicker.selectRow(rowToSelect, inComponent: 0, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func choosePicker(){
        switch customizeCellSelected {
        case 0:
            arrayToUse = ascendingDescending
            
            let ascendingBool = UserDefaults.standard.bool(forKey: DefaultsKeys.isAscendingKey)
            
            if ascendingBool {
                rowToSelect = 0
            } else {
                rowToSelect = 1
            }
        case 1:
            arrayToUse = wavingOrNot
            let wavingBool = UserDefaults.standard.bool(forKey: DefaultsKeys.isWavingKey)
            if wavingBool {
                rowToSelect = 0
            } else {
                rowToSelect = 1
            }
        case 2:
            arrayToUse = convertToStringArray(arrayToConvert: maximumNumberOfReps)
            rowToSelect = UserDefaults.standard.integer(forKey: DefaultsKeys.maximumRepsKey) - 3
        case 3:
            arrayToUse = convertToStringArray(arrayToConvert: timePerRepetition)
            rowToSelect = UserDefaults.standard.integer(forKey: DefaultsKeys.timePerRepKey) - 2
        case 4:
            arrayToUse = convertToStringArray(arrayToConvert: restPerRepetition)
            rowToSelect = UserDefaults.standard.integer(forKey: DefaultsKeys.restPerRepKey) - 2
        case 5:
            arrayToUse = convertToStringArray(arrayToConvert: laddersToDo)
            rowToSelect = UserDefaults.standard.integer(forKey: DefaultsKeys.laddersToDoKey) - 1
        case 6:
            arrayToUse = convertToStringArray(arrayToConvert: restBetweenLadders)
            rowToSelect = UserDefaults.standard.integer(forKey: DefaultsKeys.restBetweenLaddersKey) / 60 - 1
        default:
            break
        }
    }
    
    
}

extension PickerController {
    //Contains the functions that create each picker option depending on customize selection
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayToUse.count
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return arrayToUse[row]
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch customizeCellSelected {
        case 0:
            if row == 0 {
                UserDefaults.standard.set(true, forKey: DefaultsKeys.isAscendingKey)
            } else {
                UserDefaults.standard.set(false, forKey: DefaultsKeys.isAscendingKey)
            }
        case 1:
            if row == 0 {
                UserDefaults.standard.set(true, forKey: DefaultsKeys.isWavingKey)
            } else {
                UserDefaults.standard.set(false, forKey: DefaultsKeys.isWavingKey)
            }
        case 2:
            UserDefaults.standard.set(row + 3, forKey: DefaultsKeys.maximumRepsKey)
        case 3:
            UserDefaults.standard.set(row + 2, forKey: DefaultsKeys.timePerRepKey)
        case 4:
            UserDefaults.standard.set(row + 2, forKey: DefaultsKeys.restPerRepKey)
        case 5:
            UserDefaults.standard.set(row + 1, forKey: DefaultsKeys.laddersToDoKey)
        case 6:
            UserDefaults.standard.set((row + 1) * 60, forKey: DefaultsKeys.restBetweenLaddersKey)
        default:
            break
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Avenir", size: 20)
            pickerLabel?.textAlignment = .center
            pickerLabel?.textColor = .white
            pickerLabel?.text = arrayToUse[row]
        }
        
        return pickerLabel!
    }
    
    func convertToStringArray(arrayToConvert: [Int]) -> [String] {
        
        var finalArray: [String] = []
        
        for i in 0...arrayToConvert.count - 1 {
            finalArray.append(String(arrayToConvert[i]))
        }
        
        return finalArray
    }
    
}
