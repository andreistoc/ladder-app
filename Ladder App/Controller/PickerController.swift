//
//  PickerController.swift
//  Ladder App
//
//  Created by Andrew Istoc on 19/09/2018.
//  Copyright © 2018 Andrew Istoc. All rights reserved.
//

import UIKit

class PickerController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //Descriptions for all the settings
    let titlesArray = ["Select Direction", "Waving ladder or not?", "Maximum number of reps", "Time per repetition", "Rest needed per rep", "Number of ladders to do", "Rest between ladders"]
    let descriptionsArray = ["Adjusts the way the sets are arranged. From high to low or from low to high. In the case of waving ladders ascending means the first set is a set of 1 rep, and descending means that the ladder starts with the maximum number of reps selected", "If set to \"YES\" the sets will be interspersed. So an ascending ladder will have a rep scheme of (1,5,2,4,3) and a descending one will be (5,1,4,2,3). If you set it to no, the ladders will be normal, (1,2,3,4,5) if ascending or (5,4,3,2,1) if descending.", "Selects the maximum number of reps that the ladder goes up to. For example, if set to 6, the ladder scheme will be (1,2,3,4,5,6).","Selects the amount of time you need per repetition. Estimate this based on your needs. Experiment, and then tweak as necessary until you find a value that works great for you!","In ladder workouts, you get a fixed amount of rest for each repetition you perform. This insures you can fit as much volume into as little time as possible. Experiment with this too, and find what works for your goals. Generally you need more rest if you do harder exercises or lift weights that are heavy for you.", "This is simply how many times you repeat your ladder scheme. Do not do too many ladders in a single workout. Keeping this number below 4 is a good rule of thumb. If you want more work, increase the maximum number of reps, do a harder exercise, or increase the weight you use for the exercise.", "This sets how many minutes of rest to get between the ladders in your workout. If you are working for hypertrophy and size, you want to have a number that is generally under 5 minutes, but is still enough for you to continue your workout without failing. If you are training for strength with low numbers of reps and heavy weights, you should probably get 5 minutes of rest or more, as needed."]
    
    
    
    
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
    
    
    //Text outlets
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    
    
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
            titleTextView.text = titlesArray[0]
            descriptionTextView.text = descriptionsArray[0]
        case 1:
            arrayToUse = wavingOrNot
            let wavingBool = UserDefaults.standard.bool(forKey: DefaultsKeys.isWavingKey)
            if wavingBool {
                rowToSelect = 0
            } else {
                rowToSelect = 1
            }
            titleTextView.text = titlesArray[1]
            descriptionTextView.text = descriptionsArray[1]
        case 2:
            arrayToUse = convertToStringArray(arrayToConvert: maximumNumberOfReps)
            rowToSelect = UserDefaults.standard.integer(forKey: DefaultsKeys.maximumRepsKey) - 3
            titleTextView.text = titlesArray[2]
            descriptionTextView.text = descriptionsArray[2]
        case 3:
            arrayToUse = convertToStringArray(arrayToConvert: timePerRepetition)
            rowToSelect = UserDefaults.standard.integer(forKey: DefaultsKeys.timePerRepKey) - 2
            titleTextView.text = titlesArray[3]
            descriptionTextView.text = descriptionsArray[3]
        case 4:
            arrayToUse = convertToStringArray(arrayToConvert: restPerRepetition)
            rowToSelect = UserDefaults.standard.integer(forKey: DefaultsKeys.restPerRepKey) - 2
            titleTextView.text = titlesArray[4]
            descriptionTextView.text = descriptionsArray[4]
        case 5:
            arrayToUse = convertToStringArray(arrayToConvert: laddersToDo)
            rowToSelect = UserDefaults.standard.integer(forKey: DefaultsKeys.laddersToDoKey) - 1
            titleTextView.text = titlesArray[5]
            descriptionTextView.text = descriptionsArray[5]
        case 6:
            arrayToUse = convertToStringArray(arrayToConvert: restBetweenLadders)
            rowToSelect = UserDefaults.standard.integer(forKey: DefaultsKeys.restBetweenLaddersKey) / 60 - 1
            titleTextView.text = titlesArray[6]
            descriptionTextView.text = descriptionsArray[6]
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


